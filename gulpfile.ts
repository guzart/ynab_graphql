import * as fs from "fs";
import * as gulp from "gulp";
import * as path from "path";
import { flatten, includes, snakeCase, template } from "lodash";

interface Tools {
  getDefinition: (refPath: string) => undefined | Definition;
  getTargetName: (refPath: string) => undefined | string;
}

type StringHash = { [key: string]: string };

type DefinitionProperties = { [key: string]: Definition };

interface AllOfDefinition {
  allOf: Definition[];
}

interface ScalarDefinition {
  type: string | string[];
  description?: string;
  format?: string;
}

interface ArrayDefinition {
  type: "array";
  items: Definition;
}

interface ObjectDefinition {
  type?: "object";
  required: string[];
  properties: DefinitionProperties;
}

interface ReferenceDefinition {
  $ref: string;
}

type Definition =
  | AllOfDefinition
  | ReferenceDefinition
  | ScalarDefinition
  | ArrayDefinition
  | ObjectDefinition;

type DefinitionsHash = { [key: string]: undefined | Definition };

interface Model {
  name: string;
  fields: Field[];
}

interface Field {
  name: string;
  type: FieldType;
  referenceName?: string;
}

type FieldType =
  | "EmbeddedOne"
  | "EmbeddedMany"
  | "EmbeddedIn"
  | "String"
  | "Array"
  | "BigDecimal"
  | "Boolean"
  | "Date"
  | "DateTime"
  | "Float"
  | "Hash"
  | "Integer"
  | "BSON::ObjectId"
  | "BSON::Binary"
  | "Range"
  | "Regexp"
  | "String"
  | "Symbol"
  | "Time"
  | "TimeWithZone";

const isReferenceDefinition = (def: Definition): def is ReferenceDefinition => {
  return (<ReferenceDefinition>def).$ref !== undefined;
};

const isScalarDefinition = (def: Definition): def is ScalarDefinition => {
  const scalarDef = <ScalarDefinition>def;
  if (typeof scalarDef.type === "string") {
    return ["array", "object"].indexOf(scalarDef.type) === -1;
  } else {
    return includes(scalarDef.type, "array");
  }
};

const isArrayDefinition = (def: Definition): def is ArrayDefinition => {
  return (<ArrayDefinition>def).type === "array";
};

const isObjectDefinition = (def: Definition): def is ObjectDefinition => {
  return (<ObjectDefinition>def).properties !== undefined;
};

const isAllOfDefinition = (def: Definition): def is AllOfDefinition => {
  return (<AllOfDefinition>def).allOf !== undefined;
};

const getReferenceName = (refPath: string) => {
  if (refPath.indexOf("#/definitions/") === 0) {
    return refPath.replace("#/definitions/", "");
  }

  return undefined;
};

const getFieldType = (def: Definition): FieldType => {
  if (isReferenceDefinition(def)) {
    return "EmbeddedOne";
  } else if (isArrayDefinition(def)) {
    const itemsType = getFieldType(def.items);
    if (itemsType === "EmbeddedOne") {
      return "EmbeddedMany";
    }
    return itemsType;
  } else if (isScalarDefinition(def)) {
    if (def.type === "boolean") {
      return "Boolean";
    } else if (def.type === "number") {
      return "Integer";
    }
  }

  return "String";
};

const isEmbedFieldType = (type: FieldType) =>
  type === "EmbeddedOne" || type === "EmbeddedMany" || type === "EmbeddedIn";

const getFieldReferenceName = (tools: Tools, def: Definition) => {
  let name: string | undefined;

  if (isReferenceDefinition(def)) {
    name = def.$ref;
  } else if (isArrayDefinition(def) && isReferenceDefinition(def.items)) {
    name = def.items.$ref;
  }

  return name ? tools.getTargetName(name) : undefined;
};

const extractFieldsFromProps = (tools: Tools, definition: ObjectDefinition) => {
  const fields: Field[] = [];

  const { properties } = definition;
  Object.keys(properties).forEach(name => {
    const propertyDef = properties[name];
    const type = getFieldType(propertyDef);
    const referenceName = getFieldReferenceName(tools, propertyDef);
    fields.push({
      name,
      type,
      referenceName
    });
  });

  return fields;
};

const extractFields = (
  tools: Tools,
  definition?: Definition,
  final: boolean = false
): Field[] => {
  let fields: Field[] = [];

  if (!definition) {
    return fields;
  }

  if (isAllOfDefinition(definition)) {
    fields = fields.concat(
      flatten(definition.allOf.map(d => extractFields(tools, d)))
    );
  }

  if (isObjectDefinition(definition)) {
    fields = fields.concat(extractFieldsFromProps(tools, definition));
  }

  if (isReferenceDefinition(definition)) {
    const refDefinition = tools.getDefinition(definition.$ref);
    if (refDefinition) {
      fields = fields.concat(extractFields(tools, refDefinition));
    }
  }

  return fields;
};

interface Context {
  definitions: any;
  definitionMap: StringHash;
  tools: Tools;
}

const buildContext = (): Context => {
  const { definitions } = require("./spec-swagger.json");
  const definitionMap: StringHash = {
    Account: "Account",
    BudgetDetail: "Budget",
    Category: "Category",
    CategoryGroup: "CategoryGroup",
    CurrencyFormat: "CurrencyFormat",
    DateFormat: "DateFormat",
    MonthDetail: "Month",
    Payee: "Payee",
    PayeeLocation: "PayeeLocation",
    ScheduledSubTransaction: "ScheduledSubtransaction",
    ScheduledTransactionSummary: "ScheduledTransaction",
    SubTransaction: "Subtransaction",
    TransactionSummary: "Transaction"
  };

  const tools: Tools = {
    getDefinition: (path: string) => definitions[getReferenceName(path) || ""],
    getTargetName: (path: string) => definitionMap[getReferenceName(path) || ""]
  };

  return {
    definitions,
    definitionMap,
    tools
  };
};

const extractModels = ({ definitions, definitionMap, tools }: Context) => {
  return Object.keys(definitionMap).map(defName => {
    const name = definitionMap[defName];
    const definition = definitions[defName];
    const fields = extractFields(tools, definition);
    return { name, fields };
  });
};

const modelTemplate = template(`class <%= name %>
  include Mongoid::Document
end`);

const getEmbedFieldDescription = (field: Field) =>
  field.type === "EmbeddedOne"
    ? `embeds_one :${field.name}`
    : field.type === "EmbeddedMany"
      ? `embeds_many :${field.name}`
      : `embedded_in :${field.name}`;

const getFieldDescription = (field: Field) =>
  isEmbedFieldType(field.type)
    ? getEmbedFieldDescription(field)
    : `field :${field.name}, type: ${field.type}`;

const ensureFieldDescription = (
  modelContent: string,
  fieldDescription: string
) =>
  modelContent.indexOf(fieldDescription) === -1
    ? modelContent.replace(
        /include Mongoid::Document\n(\n)?/,
        `include Mongoid::Document\n\n  ${fieldDescription}\n`
      )
    : modelContent;

const ensureModelFile = (filepath: string, modelName: string) =>
  !fs.existsSync(filepath) &&
  fs.writeFileSync(filepath, modelTemplate({ name: modelName }));

const writeModels = (context: Context, models: Model[]) => {
  const modelsPath = path.resolve("app/models");
  const getModelFilepath = (name: string) =>
    path.join(modelsPath, `${snakeCase(name)}.rb`);

  models.forEach(model => {
    const filepath = getModelFilepath(model.name);
    ensureModelFile(filepath, model.name);

    let modelContents = fs.readFileSync(filepath).toString();
    model.fields.forEach(field => {
      const fieldDescription = getFieldDescription(field);
      modelContents = ensureFieldDescription(modelContents, fieldDescription);

      if (field.referenceName) {
        const relationModelFilepath = getModelFilepath(field.referenceName);
        ensureModelFile(relationModelFilepath, field.referenceName);

        const relationFieldDescription = getFieldDescription({
          name: snakeCase(model.name),
          type: "EmbeddedIn"
        });
        const relationModelContent = ensureFieldDescription(
          fs.readFileSync(relationModelFilepath).toString(),
          relationFieldDescription
        );

        fs.writeFileSync(relationModelFilepath, relationModelContent);
      }
    });

    fs.writeFileSync(filepath, modelContents);
  });
};

gulp.task("swagger", () => {
  const context = buildContext();
  const models = extractModels(context);
  // console.log(JSON.stringify(models, null, 2));
  writeModels(context, models);
});
