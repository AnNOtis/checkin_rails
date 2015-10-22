require 'rails_helper'

RSpec.describe '/api/v1/device/checkins' do
  let(:device) { create(:device) }

  describe 'GET /api/v1/device/checkins' do
    it 'returns a list of all checkins' do
      create(:checkin)
      create(:checkin, name: '另一個打卡')
      get '/api/v1/device/checkins', device_token: device.device_token

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
        get '/api/v1/device/checkins', \
          device_token: device.device_token, lat: current_lat, lng: current_lng, radius: 50

        expect(json_body['checkins'].count).to eq(2)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /api/v1/device/checkins' do
    let(:checkin_attributes){ attributes_for(:checkin) }

    it 'creates the checkins' do
      post '/api/v1/device/checkins', checkin_attributes.merge!(device_token: device.device_token)

      expect(json_body['checkin']['name']).to eq(checkin_attributes[:name])
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /api/v1/device/checkins/:id' do
    let(:update_attributes){ Hash(name: '更改地點名稱') }

    context 'if your checkin' do
      let!(:checkin){ create(:checkin, id: 1, user: device.user) }

      it 'updates the checkins' do
        put '/api/v1/device/checkins/1', update_attributes.merge!(device_token: device.device_token)

        expect(json_body['checkin']['name']).to eq(update_attributes[:name])
        expect(response.status).to eq(200)
      end
    end

    context 'if not your checkin' do
      let!(:checkin){ create(:checkin, id: 1) }

      it 'render errors' do
        put '/api/v1/device/checkins/1', update_attributes.merge!(device_token: device.device_token)

        expect(json_body['errors']).to eq('Not your checkin')
        expect(response.status).to eq(403)
      end
    end
  end

  describe 'DELETE /api/v1/device/checkins/:id' do
    context 'if your checkin' do
      let!(:checkin){ create(:checkin, id: 1, user: device.user) }

      it 'destroy the checkins' do
        expect do
          delete '/api/v1/device/checkins/1', device_token: device.device_token
        end.to change{ Checkin.count }.by(-1)

        expect(response.status).to eq(204)
      end
    end

    context 'if not your checkin' do
      let!(:checkin){ create(:checkin, id: 1) }

      it 'render errors' do
        delete '/api/v1/device/checkins/1', device_token: device.device_token

        expect(json_body['errors']).to eq('Not your checkin')
        expect(response.status).to eq(403)
      end
    end
  end
end
