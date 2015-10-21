require 'rails_helper'
RSpec.describe Checkin do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  context 'when create checkin' do
    it 'saves address value automatically' do
      checkin = create(:checkin, latitude: 40.7143528, longitude: -74.0059731)

      expect(checkin.address).to eq('New York, NY, USA')
    end
  end
end
