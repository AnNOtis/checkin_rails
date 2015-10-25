class API::V1::CheckinsController < API::BaseController
  def index
    @checkins =
      if params[:lat] && params[:lng] && params[:radius]
        Checkin.near([params[:lat], params[:lng]], params[:radius])
      else
        Checkin.limit(100)
      end

    render json: @checkins, status: 200
  end
end
