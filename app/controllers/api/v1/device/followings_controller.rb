class API::V1::Device::FollowingsController < API::V1::Device::BaseController
  def create
    following = User.find(params[:following_id])

    if current_user.follow(following)
      render json: following, status: 201
    else
      render_error(message: current_user.errors.full_messages, status: 422)
    end
  end
end
