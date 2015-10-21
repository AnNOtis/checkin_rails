class API::BaseController < ActionController::Base
  rescue_from StandardError, with: :render_server_error

  def render_error(message:, status: 400)
    render json: { errors: message }, status: status
  end

  private

  def render_server_error(exception)
    render json: { errors: exception.message }, status: 500
  end
end
