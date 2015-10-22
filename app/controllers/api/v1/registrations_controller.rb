class API::V1::RegistrationsController < API::BaseController
  before_action :check_device_token, only: [:create]
  before_action :find_user, only: [:create]

  def create
    if @user.persisted? || @user.save
      render json: @user, status: 201, root: true
    else
      render_error(message: @user.errors.full_messages, status: 422)
    end
  end

  private

  def find_user
    @user = UserDeviceService.find_or_initialize_with(
      registration_params,
      user_agent: request.user_agent,
      device_token: params[:device_token]
    )
  end

  def registration_params
    params.permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def check_device_token
    if params[:device_token].blank?
      return render_error(message: "token can'be blank!")
    end
  end
end
