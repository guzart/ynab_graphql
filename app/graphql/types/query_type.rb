Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :budgets, types[Types::BudgetType] do
    description "List budgets"
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end

  field :accounts, types[Types::AccountType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end
end
