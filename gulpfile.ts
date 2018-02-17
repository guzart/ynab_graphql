import * as gulp from "gulp";
import { flatten } from "lodash";

type StringHash = { [key: string]: string };

type DefinitionProperties = { [key: string]: Definition };

interface AllOfDefinition {
  allOf: Definition[];
}

interface ScalarDefinition {
  type: string;
  description?: string;
  format?: string;
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
  | ObjectDefinition;

type DefinitionsHash = { [key: string]: undefined | Definition };

interface Field {
  name: string;
  type:
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
}

const isReferenceDefinition = (def: Definition): def is ReferenceDefinition => {
  return (<ReferenceDefinition>def).$ref !== undefined;
};

const isObjectDefinition = (def: Definition): def is ObjectDefinition => {
  return (<ObjectDefinition>def).properties !== undefined;
};

const isAllOfDefinition = (def: Definition): def is AllOfDefinition => {
  return (<AllOfDefinition>def).allOf !== undefined;
};

const extractFieldsFromProps = (definition: ObjectDefinition) => {
  console.log(definition);
  const { properties } = definition;
  const fields: Field[] = [];
  return fields;
};

const extractFields = (
  definitionGetter: ((name: string) => undefined | Definition),
  definition?: Definition
): Field[] => {
  let fields: Field[] = [];

  if (!definition) {
    return fields;
  }

  if (isAllOfDefinition(definition)) {
    fields = fields.concat(
      flatten(definition.allOf.map(d => extractFields(definitionGetter, d)))
    );
  }

  if (isObjectDefinition(definition)) {
    fields = fields.concat(extractFieldsFromProps(definition));
  }

  if (isReferenceDefinition(definition)) {
    const refDefinition = definitionGetter(definition.$ref);
    if (refDefinition) {
      fields = fields.concat(extractFields(definitionGetter, refDefinition));
    }
  }

  return fields;
};

gulp.task("swagger", () => {
  const definitionMap: StringHash = {
    Account: "Account",
    BudgetDetail: "Budget",
    Category: "Category",
    CategoryGroup: "CategoryGroup",
    MonthDetail: "BudgetMonth",
    Payee: "Payee",
    PayeeLocation: "PayeeLocation",
    ScheduledSubTransaction: "ScheduledSubTransaction",
    ScheduledTransactionSummary: "ScheduledTransaction",
    SubTransaction: "SubTransaction",
    TransactionSummary: "Transaction"
  };

  // TODO: use embeds and embedded_in
  // We'll need to pass around the current tree, so that each step could
  // potentially modify it
  // https://docs.mongodb.com/mongoid/master/tutorials/mongoid-relations/#embeds-many

  const swagger = require("./spec-swagger.json");

  const definitions: DefinitionsHash = swagger.definitions;
  const definitionGetter = (path: string) => {
    if (path.indexOf("#/definitions/") === 0) {
      const name = path.replace("#/definitions/", "");
      return definitions[name];
    }

    return undefined;
  };

  Object.keys(definitionMap).forEach(name => {
    const targetFilename = definitionMap[name];
    const definition = definitions[name];
    const fields = extractFields(definitionGetter, definition);
  });
});
