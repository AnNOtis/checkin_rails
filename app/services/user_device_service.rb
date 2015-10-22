class UserDeviceService
  def self.find_or_initialize_with(info_params, user_agent:, device_token:)
    user = User.find_or_initialize_with info_params

    user.devices.build(device_token: device_token, user_agent: user_agent)

    user
  end
end
