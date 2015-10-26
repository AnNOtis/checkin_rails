require 'rails_helper'
RSpec.describe Device do
  it { is_expected.to validate_presence_of(:device_token) }
  it { is_expected.to validate_uniqueness_of(:device_token) }

  describe '#ensure_device_token' do
    let(:device) { build(:device, device_token: nil) }

    context 'without device_token' do
      it 'generate token' do
        device.ensure_device_token
        expect(device.device_token).to be_present
      end
    end
  end
end
