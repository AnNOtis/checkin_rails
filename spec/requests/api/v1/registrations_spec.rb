require 'rails_helper'

RSpec.describe '/api/v1/registrations' do
  describe 'POST register user' do
    context 'when user not exist' do
      let(:user_attributes) { attributes_for(:user).merge({ device_token: '123456789' }) }
      it 'creates user and device' do
        user_count = User.count
        device_count = Device.count
        post '/api/v1/registrations', user_attributes

        expect(User.count).to eq(user_count + 1)
        expect(Device.count).to eq(device_count + 1)

        user_json = json_body['user']
        expect(user_json['name']).to eq(user_attributes[:name])
        expect(user_json['email']).to eq(user_attributes[:email])
        expect(response.status).to eq(201)
      end
    end

    context 'when user exist' do
      it 'creates device belongs to user' do
        user = create(:user)
        expect do
          post(
            '/api/v1/registrations',
            email: user.email,
            password: user.password,
            device_token: '123456789'
          )
        end.to change{ Device.count }.by(1)

        expect(response.status).to eq(201)
      end
    end

    context 'when device exist' do
      it 'returns errors' do
        user = create(:user)
        device = user.devices.create(device_token: '123456789')

        post(
          '/api/v1/registrations',
          email: user.email,
          password: user.password,
          device_token: device.device_token
        )

        expect(json_body.fetch('errors')).not_to be_empty
        expect(response.status).to eq(422)
      end
    end

    context 'with invalid value' do
      it 'returns error messages' do
        post '/api/v1/registrations', attributes_for(:user, :invalid)
        expect(json_body.fetch('errors')).not_to be_empty
        expect(response.status).to eq(422)
      end
    end
  end
end
