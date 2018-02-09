class ApplicationController < ActionController::API
  NotAuthorizedError = Class.new(StandardError)

  before_action :authorize!

  rescue_from NotAuthorizedError, with: :unauthorized

  private

  def authorize!
    if request.headers['x-api-key'] != ENV['API_KEY']
      raise NotAuthorizedError
    end
  end

  def unauthorized
    render status: :unauthorized, json: { message: 'Not authorized' }
  end
end
