Types::CurrencyFormatType = GraphQL::ObjectType.define do
  name "CurrencyFormat"
  field :locale, !types.String
end
