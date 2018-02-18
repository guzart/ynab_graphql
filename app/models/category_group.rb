class CategoryGroup
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :name, type: String
  field :hidden, type: Boolean
end
