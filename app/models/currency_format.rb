class CurrencyFormat
  include Mongoid::Document

  embedded_in :budget
  field :iso_code, type: String
  field :example_format, type: String
  field :decimal_digits, type: Integer
  field :decimal_separator, type: String
  field :symbol_first, type: Boolean
  field :group_separator, type: String
  field :currency_symbol, type: String
  field :display_symbol, type: Boolean
end
