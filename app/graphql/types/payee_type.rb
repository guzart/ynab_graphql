Types::PayeeType = GraphQL::ObjectType.define do
  name "Payee"
  field :id, !types.String
  field :name, !types.String

  field :transfer_account, Types::AccountType do
    description "If a transfer payee, the account to which this payee transfers to"
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end

  field :locations, types[Types::PayeeLocationType] do
    resolve ->(_obj, _args, _ctx) {
      []
    }
  end
end
