class Month
  include Mongoid::Document

  embedded_in :budget
  field :month, type: String
  field :age_of_money, type: String
  field :to_be_budgeted, type: String
  field :note, type: String
  embeds_many :categories
end
