class Transaction
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :account_id, type: String
  field :amount, type: Integer
  field :approved, type: Boolean
  field :category_id, type: String
  field :cleared, type: String
  field :date, type: String
  field :flag_color, type: String
  field :import_id, type: String
  field :memo, type: String
  field :payee_id, type: String
  field :transfer_account_id, type: String
end
