Types::SubTransactionType = GraphQL::ObjectType.define do
  name "SubTransaction"
  field :id, !types.String
  field :amount, !types.Int
  field :memo, !types.String

  field :transaction, Types::TransactionType do
    resolve ->(_obj, _arg, _ctx) {
      nil
    }
  end

  field :payee, Types::PayeeType do
    resolve ->(_obj, _arg, _ctx) {
      nil
    }
  end

  field :category, Types::CategoryType do
    resolve ->(_obj, _arg, _ctx) {
      nil
    }
  end

  field :transfer_account, Types::AccountType do
    resolve ->(_obj, _arg, _ctx) {
      nil
    }
  end
end
