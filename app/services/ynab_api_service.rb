class YNABApiService
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def budgets
    response = get('/budgets')
    open_struct response['data']['budgets']
  end

  def budget(budget_id)
    response = get("/budgets/#{budget_id}")
    open_struct response['data']['budget']
  end

  def accounts(budget_id)
    response = get("/budgets/#{budget_id}/accounts")
    open_struct response['data']['accounts']
  end

  def account(budget_id, account_id)
    response = get("/budgets/#{budget_id}/accounts/#{account_id}")
    open_struct response['data']['account']
  end

  private

  def get(path)
    cache_fetch(path) do
      response = HTTParty.get(path, request_options)
      response.parsed_response
    end
  end

  def request_options
    headers = { 'Authorization': "Bearer #{access_token}"}
    { base_uri: 'https://api.youneedabudget.com/papi/v1/', headers: headers }
  end

  def open_struct(data)
    if data.is_a?(Array)
      return data.map { |i| open_struct(i) }
    elsif data.is_a?(Hash)
      OpenStruct.new(
        data.each_with_object({}) do |(key, val), memo|
          memo[key] = val.is_a?(Hash) ? open_struct(val) : val
        end
      )
    else
      data
    end
  end

  def cache_fetch(key)
    Rails.cache.fetch(cache_key(key), expires_in: 12.hours) do
      yield
    end
  end

  def cache_key(*values)
    [cache_prefix].concat(values).join('/')
  end

  def cache_prefix
    @cache_prefix ||= Digest::SHA1.hexdigest(access_token)
  end
end
