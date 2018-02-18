class Account
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :name, type: String
  field :type, type: String
  field :balance, type: Integer
  field :cleared_balance, type: Integer
  field :closed, type: Boolean
  field :note, type: String
  field :on_budget, type: Boolean
  field :uncleared_balance, type: Integer
end
