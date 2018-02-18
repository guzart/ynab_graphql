class DateFormat
  include Mongoid::Document

  embedded_in :budget
  field :format, type: String
end
