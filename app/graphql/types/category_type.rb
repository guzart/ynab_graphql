Types::CategoryType = GraphQL::ObjectType.define do
  name "Category"
  field :id, !types.String
  field :name, !types.String
  field :hidden, !types.Boolean, "Whether or not the category is hidden"
  field :note, types.String
  field :budgeted, !types.Int, "Budgeted amount in current month in milliunits format"
  field :activity, !types.Int, "Activity amount in current month in milliunits format"
  field :balance, !types.Int, "Balance in current month in milliunits format"

  field :category_group, Types::CategoryGroupType do
    resolve ->(_obj, _arg, _ctx) {
      nil
    }
  end
end
