class PayeeLocation
  include Mongoid::Document

  embedded_in :budget
  field :id, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :payee_id, type: String
end
