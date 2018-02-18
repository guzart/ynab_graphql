Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :budgets, types[Types::BudgetType] do
    description "List budgets"
    resolve ->(_obj, _args, ctx) {
      ctx[:budget_repository].user_budgets
    }
  end

  field :accounts, types[Types::AccountType] do
    description "List budget accounts"
    argument :budget_id, types.String
    resolve ->(_obj, args, ctx) {
      ctx[:budget_repository].budget_accounts(args[:budget_id])
    }
  end

  field :transactions, types[Types::TransactionType] do
    description "List budget or account transactions"
    argument :budget_id, !types.String
    argument :account_id, types.String

    resolve ->(_obj, _args, _ctx) {
      []
    }
  end
end
