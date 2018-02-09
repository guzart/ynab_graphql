Types::AccountType = GraphQL::ObjectType.define do
  name "Account"
  field :id, !types.String
  field :name, !types.String
  field :type, !Types::AccountTypeType
  field :on_budget, !types.Boolean
  field :closed, !types.Boolean
  field :note, !types.String
  field :balance, !types.Int
  field :cleared_balance, !types.Int
  field :uncleared_balance, !types.Int
end
