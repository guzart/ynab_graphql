Types::TransactionType = GraphQL::ObjectType.define do
  name "Transaction"
  field :id, !types.String
  field :date, !types.String
  field :amount, !types.Int
  field :memo, !types.String
  field :cleared, !Types::TransactionClearanceType
  field :approved, !types.Boolean
  field :flag_color, !types.String
  field :subtransactions, !types[Types::SubTransactionType]

  field :account, Types::AccountType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

  field :payee, Types::PayeeType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

  field :category, Types::CategoryType do
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
