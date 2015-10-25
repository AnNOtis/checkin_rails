RSpec.describe '/api/v1/checkins' do
  describe 'GET /api/v1/checkins' do
    it 'returns a list of all checkins' do
      create(:checkin)
      create(:checkin, name: '另一個打卡')
      get '/api/v1/checkins'

      expect(json_body['checkins'].count).to eq(2)
      expect(response.status).to eq(200)
    end

    context 'when query near checkins' do
      let(:current_lat){ 25.0477505 }
      let(:current_lng){ 121.5148712 }

      before do
        create(:checkin, latitude: 25.047099, longitude: 121.516974) #64m
        create(:checkin, latitude: 24.718455, longitude: 121.360017) #39.91km
        create(:checkin, latitude: 23.624387, longitude: 120.682441) #179.11km
      end

      it 'return a list of near checkins in radius' do
        get '/api/v1/checkins', \
          lat: current_lat, lng: current_lng, radius: 50

        expect(json_body['checkins'].count).to eq(2)
        expect(response.status).to eq(200)
      end
    end
  end
end
