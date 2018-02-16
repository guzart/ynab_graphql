Types::CurrencyFormatType = GraphQL::ObjectType.define do
  name "CurrencyFormat"
  field :iso_code, types.String
  field :example_format, types.String
  field :decimal_digits, types.Int
  field :decimal_separator, types.String
  field :symbol_first, types.Boolean
  field :group_separator, types.String
  field :currency_symbol, types.String
  field :display_symbol, types.Boolean
end
