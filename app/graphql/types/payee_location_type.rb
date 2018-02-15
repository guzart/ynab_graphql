Types::PayeeLocationType = GraphQL::ObjectType.define do
  name "PayeeLocation"
  field :id, !types.String
  field :latitude, types.String
  field :longitude, types.String

  field :payee, Types::PayeeType do
    resolve ->(_obj, _args, _ctx) {
      nil
    }
  end
end
