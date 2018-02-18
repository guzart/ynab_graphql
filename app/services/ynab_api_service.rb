class YNABApiService
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def budgets
    response = get('/budgets')
    response['data']['budgets'].map do |budget_data|
      budget_data.merge('user_hash' => user_hash)
    end
  end

  # TODO: Pass server knowledge parameter
  def full_budget(budget_id)
    response = get("/budgets/#{budget_id}")
    server_knowledge = response['data']['server_knowledge']
    response['data']['budget'].merge(
      'user_hash' => user_hash,
      'server_knowledge' => server_knowledge
    )
  end

  private

  def get(path)
    response = HTTParty.get(path, request_options)
    response.parsed_response
  end

  def request_options
    headers = { 'Authorization': "Bearer #{access_token}"}
    { base_uri: 'https://api.youneedabudget.com/papi/v1/', headers: headers }
  end

  def user_hash
    @user_hash ||= begin
      key = Rails.application.secrets[:secret_key_base]
      OpenSSL::HMAC.hexdigest("SHA512", key, access_token)
    end
  end
end
