RSpec.describe '/api/v1/registrations' do
  describe 'POST' do
    context 'when register user' do
      let(:user_attributes) {
        {
          name: 'LETMEIN',
          email: 'letmein@gmail.com',
          password: '12345678',
          password_confirmation: '12345678'
        }
      }

      it 'returns info included access_token' do
        post '/api/v1/registrations', attributes_for(:user)

        expect(User.count).to eq(1)
        expect(Device.count).to eq(1)

        user_json = json_body['user']
        expect(user_json.name).to eq(user_attributes.name)
        expect(user_json.email).to eq(user_attributes.email)
        expect(user_json.access_token).to eq(user_attributes.access_token)
        expect(response.status).to eq(201)
      end
    end
    context 'when register user with invalid value' do
      it 'return error messages' do
        post '/api/v1/registrations', attributes_for(:user, :invalid)
        expect(json_body.fetch("errors")).not_to be_empty
        expect(response.status).to eq 422
      end
    end
  end
end
