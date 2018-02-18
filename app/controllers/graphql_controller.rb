class GraphqlController < ApplicationController
  def execute
    result = YNABGraphqlSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: build_context,
      operation_name: params[:operationName]
    )
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def build_context
    access_token = ENV['YNAB_ACCESS_TOKEN']
    {
      access_token: access_token,
      budget_repository: BudgetRepository.new(access_token)
    }
  end
end
