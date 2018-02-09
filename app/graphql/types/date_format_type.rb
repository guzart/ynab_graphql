Types::DateFormatType = GraphQL::ObjectType.define do
  name "DateFormat"
  field :locale, !types.String
end
