class API::V1::CheckinsController < API::V1::BaseController
  def index
    @checkins =
      if params[:lat] && params[:lng] && params[:radius]
        Checkin.includes(:user)
          .near([params[:lat], params[:lng]], params[:radius])
          .newest_first
      else
        Checkin.includes(:user).limit(100).newest_first
      end

    render json: @checkins, status: 200
  end
end
