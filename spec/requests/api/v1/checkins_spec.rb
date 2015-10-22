require 'rails_helper'

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
      it 'return a list of near checkins in radius' do
        current_lat = 25.0477505
        current_lng = 121.5148712
        create(:checkin, latitude: 25.047099, longitude: 121.516974) #64m
        create(:checkin, latitude: 24.718455, longitude: 121.360017) #39.91km
        create(:checkin, latitude: 23.624387, longitude: 120.682441) #179.11km

        get '/api/v1/checkins', lat: current_lat, lng: current_lng, radius: 50

        expect(json_body['checkins'].count).to eq(2)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /api/v1/checkins' do
    it 'creates the checkins' do
      checkin_attributes = attributes_for(:checkin)
      expect do
        post '/api/v1/checkins', checkin_attributes
      end.to change{ Checkin.count }.by(1)

      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /api/v1/checkins/:id' do
    it 'updates the checkins' do
      checkin = create(:checkin, id: 1)
      update_attributes = { name: '更改地點名稱' }
      put '/api/v1/checkins/1', update_attributes

      expect(json_body['checkin']['name']).to eq(update_attributes[:name])
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/v1/checkins/:id' do
    it 'destroy the checkins' do
      checkin = create(:checkin, id: 1)
      expect do
        delete '/api/v1/checkins/1'
      end.to change{ Checkin.count }.by(-1)

      expect(response.status).to eq(204)
    end
  end
end
