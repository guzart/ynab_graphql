Types::MonthType = GraphQL::ObjectType.define do
  name "BudgetMonth"
  field :month, !types.String
  field :note, types.String
  field :to_be_budgeted, types.Int
  field :age_of_money, types.Int

  field :categories, types[Types::CategoryType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end

  field :category_groups, types[Types::CategoryGroupType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end
end
