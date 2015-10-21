class API::V1::RegistrationsController < API::BaseController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201, root: true
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
