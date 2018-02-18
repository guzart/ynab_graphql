class ScheduledSubtransaction
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :amount, type: Integer
  field :category_id, type: String
  field :memo, type: String
  field :payee_id, type: String
  field :scheduled_transaction_id, type: String
  field :transfer_account_id, type: String
end
