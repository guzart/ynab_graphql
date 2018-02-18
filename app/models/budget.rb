class Budget
  include Mongoid::Document

  field :id, type: String
  field :name, type: String
  field :last_modified_on, type: String
  embeds_one :date_format
  embeds_one :currency_format
  embeds_many :accounts
  embeds_many :categories
  embeds_many :category_groups
  embeds_many :months
  embeds_many :payee_locations
  embeds_many :payees
  embeds_many :scheduled_subtransactions
  embeds_many :scheduled_transactions
  embeds_many :subtransactions
  embeds_many :transactions
end
