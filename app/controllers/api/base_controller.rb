class API::BaseController < ActionController::Base
  rescue_from StandardError, with: :render_server_error

  private

  def render_error(message:, status: 400)
    render json: { errors: message }, status: status
  end

  def authenticate_user_from_token!
    device = Device.find_by(device_token: params[:device_token])

    if user = device.try(:user)
      sign_in :user, user, store: false
    end
  end

  def required_login
    if !current_user
      render_error(message: 'Required login', status: 401)
      return
    end
  end

  def render_server_error(exception)
    render json: { errors: exception.message }, status: 500
  end
end
