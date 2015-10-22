class API::V1::Device::FollowingsController < API::V1::Device::BaseController
  before_action :find_user_to_be_followed

  def create
    if current_user.follow(@to_follow)
      render json: @to_follow, status: 201
    else
      render_error(message: current_user.errors.full_messages, status: 422)
    end
  end

  private

  def find_user_to_be_followed
    @to_follow = User.find_by(id: params[:following_id])
  end
end
