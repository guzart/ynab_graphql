Types::BudgetType = GraphQL::ObjectType.define do
  name "Budget"
  field :id, !types.String
  field :name, !types.String
  field :last_modified_on, types.String
  field :date_format, Types::DateFormatType
  field :currency_format, Types::CurrencyFormatType

  field :accounts, types[Types::AccountType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end

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

  field :months, types[Types::BudgetMonthType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end

  field :payees, types[Types::PayeeType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end
end
