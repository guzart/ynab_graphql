Types::ScheduledSubTransactionType = GraphQL::Object.define do
  name 'ScheduledSubTransaction'
  field :id, !types.String
  field :amount, !types.Int
  field :memo, types.String

  field :category, Types::CategoryType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

  field :payee, Types::PayeeType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

  field :scheduled_transaction, Types::ScheduledTransaction do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

  field :transfer_account, Types::AccountType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end
end
