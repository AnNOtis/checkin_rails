RSpec.describe '/api/v1/registrations' do
  describe 'POST' do
    context 'when user register' do
      let(:user_attributes) { attributes_for(:user) }
      it 'returns user info' do
        post '/api/v1/registrations', user_attributes

        expect(User.count).to eq(1)

        user_json = json_body['user']
        expect(user_json['name']).to eq(user_attributes[:name])
        expect(user_json['email']).to eq(user_attributes[:email])
        expect(response.status).to eq(201)
      end
    end

    context 'when user register with invalid value' do
      it 'return error messages' do
        post '/api/v1/registrations', attributes_for(:user, :invalid)
        expect(json_body.fetch('errors')).not_to be_empty
        expect(response.status).to eq 422
      end
    end
  end
end
