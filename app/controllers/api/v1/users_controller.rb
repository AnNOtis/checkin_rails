class API::V1::UsersController < API::V1::BaseController
  before_action :find_user, only: [:login]

  def login
    if @user
      @device = @user.find_or_create_device_by(user_agent: request.user_agent)
      render json: @user.as_json(root: true).merge(device_token: @device.device_token)
    else
      render_error(message: 'incorrect Email or Password', status: 422)
    end
  end

  private

  def find_user
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      @user = user
    end
  end
end
