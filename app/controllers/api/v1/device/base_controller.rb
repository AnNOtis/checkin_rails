class API::V1::Device::BaseController < API::V1::BaseController
  before_action :authenticate_user_from_token!
  before_action :required_login
end
