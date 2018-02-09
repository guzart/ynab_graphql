Types::BudgetType = GraphQL::ObjectType.define do
  name "Budget"
  field :id, !types.String
  field :name, !types.String
  field :last_modified_on, types.String
  field :date_format, Types::DateFormatType
  field :currency_format, Types::CurrencyFormatType
  field :accounts, types[Types::AccountType] do
    resolve ->(obj, _args, _ctx) {
      budget_id = obj.id
      []
    }
  end
end