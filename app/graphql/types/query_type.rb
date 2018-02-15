Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :budgets, types[Types::BudgetType] do
    description "List budgets"
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end

  field :accounts, types[Types::AccountType] do
    argument :budget_id, types.String
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end

  field :transactions, types[Types::TransactionType] do
    argument :budget_id, !types.String
    argument :account_id, types.String

    resolve ->(_obj, _args, _ctx) {
      []
    }
  end
end
