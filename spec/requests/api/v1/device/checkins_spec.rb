require 'rails_helper'

RSpec.describe '/api/v1/device/checkins' do
  let(:device) { create(:device) }

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
