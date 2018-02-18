class Category
  include Mongoid::Document

  embedded_in :budget
  embedded_in :month
  field :id, type: String
  field :name, type: String
  field :hidden, type: Boolean
  field :activity, type: Integer
  field :balance, type: Integer
  field :budgeted, type: Integer
  field :category_group_id, type: String
  field :note, type: String
end
