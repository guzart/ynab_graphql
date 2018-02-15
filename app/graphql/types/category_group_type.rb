Types::CategoryGroupType = GraphQL::ObjectType.define do
  name "CategoryGroup"
  field :id, !types.String
  field :name, !types.String
  field :hidden, !types.Boolean, "Whether or not the category group is hidden"

  field :categories, types[Types::CategoryType] do
    resolve ->(_obj, _arg, _ctx) {
      []
    }
  end
end
