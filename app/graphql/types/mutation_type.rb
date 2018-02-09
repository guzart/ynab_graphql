Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :add_transaction, types.String do
    description "Add new transaction"
    resolve ->(_obj, _args, _ctx) {
      "To be implemented"
    }
  end
end
