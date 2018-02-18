class BudgetRepository
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def user_budgets
    fetch_user_budgets
  end

  def budget_accounts(budget_id)
    fetch_full_budget(budget_id).accounts
  end

  private

  def fetch_user_budgets
    budgets = Budget.where(user_hash: user_hash)
    return budgets unless budgets.count.zero?

    request_user_budgets_data.map do |budget_data|
      Budget.create(budget_data)
    end
  end

  def request_user_budgets_data
    Rails.cache.fetch([user_hash, :budgets], expires_in: 1.hour) do
      ynab_service.budgets
    end
  end

  def fetch_full_budget(budget_id)
    budget = Budget.find_by(user_hash: user_hash, id: budget_id)
    return budget if budget && !budget.accounts.empty?

    if !budget
      budget_data = request_full_budget_data(budget_id)
      return Budget.create(budget_data)
    end

    budget_data = request_full_budget_data(budget_id)
    budget.update(budget_data)
    budget
  end

  def request_full_budget_data(budget_id)
    Rails.cache.fetch([user_hash, :budget, budget_id], expires_in: 1.hour) do
      ynab_service.full_budget(budget_id)
    end
  end

  # TODO: Move this to a module and include here and in the ynab api service
  def user_hash
    @user_hash ||= begin
      key = Rails.application.secrets[:secret_key_base]
      OpenSSL::HMAC.hexdigest("SHA512", key, access_token)
    end
  end

  def ynab_service
    @ynab_service ||= YNABApiService.new(access_token)
  end
end
