class API::V1::Device::CheckinsController < API::V1::Device::BaseController
  before_action :find_and_check_checkin, only: [:update, :destroy]

  def index
    @checkins =
      if params[:lat] && params[:lng] && params[:radius]
        Checkin.near([params[:lat], params[:lng]], params[:radius])
      else
        Checkin.limit(100)
      end

    render json: @checkins, status: 200
  end

  def create
    @checkin = current_user.checkins.build(checkin_params)

    if @checkin.save
      render json: @checkin, root: true, status: 201
    else
      render_error(message: @checkin.errors.full_messages, status: 422)
    end
  end

  def update
    if @checkin.update(checkin_params)
      render json: @checkin, root: true, status: 200
    else
      render_error(message: @checkin.errors.full_messages, status: 422)
    end
  end

  def destroy
    @checkin.destroy

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

  def find_and_check_checkin
    @checkin = Checkin.find_by(id: params[:id])
    render_error(message: 'Checkin not found', status: 404) if @checkin.blank?
    render_error(message: 'Not your checkin', status: 403) if @checkin.user != current_user
  end
end
