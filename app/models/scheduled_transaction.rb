class ScheduledTransaction
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :account_id, type: String
  field :amount, type: Integer
  field :category_id, type: String
  field :date_first, type: String
  field :date_next, type: String
  field :flag_color, type: String
  field :frequency, type: String
  field :memo, type: String
  field :payee_id, type: String
  field :transfer_account_id, type: String
end
