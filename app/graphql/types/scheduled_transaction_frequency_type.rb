Types::ScheduledTransactionFrequencyType = GraphQL::EnumType.define do
  name "ScheduledTransactionFrequencyType"
  value("never", "")
  value("daily", "")
  value("weekly", "")
  value("everyOtherWeek", "")
  value("twiceAMonth", "")
  value("every4Weeks", "")
  value("monthly", "")
  value("everyOtherMonth", "")
  value("every3Months", "")
  value("every4Months", "")
  value("twiceAYear", "")
  value("yearly", "")
  value("everyOtherYear", "")
end
