Types::AccountTypeType = GraphQL::EnumType.define do
  name "AccountType"
  value("Checking", "Checking account")
  value("Savings", "Savings account")
  value("CreditCard", "CreditCard account")
end
