RSpec.describe '/api/v1/checkins' do
  describe 'GET /api/v1/checkins' do
    it 'returns a list of all checkins' do
      create(:checkin)
      create(:checkin, name: '另一個打卡')
      get '/api/v1/checkins'

      expect(json_body['checkins'].count).to eq(2)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/checkins' do
    it 'creates the checkins' do
      checkin_attributes = attributes_for(:checkin)
      expect do
        post '/api/v1/checkins', checkin_attributes
      end.to change{ Checkin.count }.by(1)

      expect(json_body['checkin']).to eq(checkin_attributes)
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /api/v1/checkins/:id' do
    it 'updates the checkins' do
      checkin = create(:checkin)
      update_attributes = { name: '更改地點名稱' }
      put '/api/v1/checkins', { id: checkin.id }.merge(update_attributes)

      expect(json_body['checkin']).to eq(checkin.attributes.merge(update_attributes))
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/v1/checkins/:id' do
    it 'destroy the checkins' do
      checkin = create(:checkin)
      expect do
        delete '/api/v1/checkins', id: checkin.id
      end.to change{ Checkin.count }.by(1)

      expect(response.status).to eq(204)
    end
  end
end
