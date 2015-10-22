require 'rails_helper'

RSpec.describe '/api/v1/device/followings' do
  describe 'POST /api/v1/device/followings' do
    let(:device) { create(:device) }
    let(:user) { device.user }
    let(:dhh) { create(:user, name: "dhh") }

    it 'follows dhh' do
      post '/api/v1/device/followings',
        device_token: device.device_token, following_id: dhh.id

      expect(user.followings.map(&:name)).to eq ["dhh"]
    end
  end
end
