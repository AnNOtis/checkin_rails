require "rails_helper"

RSpec.describe UserDeviceService do
  describe "#find_or_create_with" do
    let(:info_params) { Hash(device_token: "token") }
    let(:device_token) { "token" }
    let(:user_agent) { "iOS 9" }

    it "invokes" do
      device = double("device")
      user = double("user", devices: device)

      expect(User).to \
        receive(:find_or_initialize_with).with(info_params).and_return(user)

      expect(device).to receive(:build).with(
        device_token: info_params[:device_token],
        user_agent: user_agent
      )

      UserDeviceService.find_or_initialize_with(
        info_params,
        device_token: device_token,
        user_agent: user_agent
      )
    end
  end
end
