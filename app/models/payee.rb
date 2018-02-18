class Payee
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :name, type: String
  field :transfer_account_id, type: String
end
