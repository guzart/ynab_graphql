Types::TransactionClearanceType = GraphQL::EnumType.define do
  name "TransactionClearance"
  value("cleared", "Cleared clearance")
  value("uncleared", "Unclearead clearance")
  value("reconciled", "Reconciled clearance")
end
