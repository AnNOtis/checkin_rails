class API::V1::Device::BaseController < API::BaseController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
end
