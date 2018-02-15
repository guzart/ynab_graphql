Types::ScheduledTransactionType = GraphQL::ObjectType.define do
  name 'ScheduledTransaction'
  field :id, !types.String
  field :date_first, !types.String
  field :date_next, !types.String
  field :frequency, !Types::ScheduledTransactionFrequencyType
  field :amount, !types.Int
  field :memo, types.String
  field :flag_color, types.String

  field :account, Types::AccountType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

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

  field :transfer_account, Types::AccountType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end
end
