Types::ScheduledTransactionFrequencyType = GraphQL::EnumType.define do
  name "ScheduledTransactionFrequencyType"
  value("never", "Never")
  value("daily", "Daily")
  value("weekly", "Weekly")
  value("everyOtherWeek", "Every other week")
  value("twiceAMonth", "Twice a month")
  value("every4Weeks", "Every four weeks")
  value("monthly", "Every month")
  value("everyOtherMonth", "Every other month")
  value("every3Months", "Every three months")
  value("every4Months", "Every four months")
  value("twiceAYear", "Twice a year")
  value("yearly", "Yearly")
  value("everyOtherYear", "Every other year")
end
