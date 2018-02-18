class CurrencyFormat
  include Mongoid::Document

  embedded_in :budget
  field :locale, type: String
end
