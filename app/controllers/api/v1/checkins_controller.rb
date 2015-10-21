class API::V1::CheckinsController < API::BaseController
  def index
    @checkins = Checkin.all

    render json: @checkins, status: 200
  end

  def create
    @checkin = Checkin.new(checkin_params)

    if @checkin.save
      render json: @checkin, root: true, status: 201
    else
      render_error(messages: @checkin.errors.full_messages, status: 422)
    end
  end

  def update
    @checkin = Checkin.find(params[:id])

    if @checkin.update(checkin_params)
      render json: @checkin, root: true, status: 200
    else
      render_error(messages: @checkin.errors.full_messages, status: 422)
    end
  end

  def destroy
    Checkin.find(params[:id]).destroy
    
    render json: {}, status: 204
  end

  private

  def checkin_params
    params.permit(
      :user_id,
      :name,
      :latitude,
      :longitude,
      :address,
      :photo,
      :comment
    )
  end
end
