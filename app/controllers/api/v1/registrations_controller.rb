class API::V1::RegistrationsController < API::BaseController
  def create
    @user =
      if user = User.find_by(email: registration_params[:email])
        if !user.valid_password?(registration_params[:password])
          render_error(message: 'email or password not correct', status: 403)
          return
        end
        user
      else
        User.new(registration_params)
      end

    @user.devices.build(device_token: params[:device_token], user_agent: request.user_agent)
    if @user.save
      render json: @user, status: 201, root: true
    else
      render_error(message: @user.errors.full_messages, status: 422)
    end
  end

  private

  def registration_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
