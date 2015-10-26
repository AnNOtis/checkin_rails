require 'rails_helper'

RSpec.describe '/api/v1/users' do
  describe 'POST login' do
    context 'with existing user' do
      let(:user) { create(:user, password: 'password', password_confirmation: 'password') }

      it 'renders correctly' do
        post '/api/v1/users/login', { email: user.email, password: 'password' }

        expect(json_body['user']['email']).to eq(user[:email])
        expect(json_body['user']['password']).to_not be_present
        expect(json_body['device_token']).to be_present
        expect(response).to have_http_status(200)
      end
    end

    context 'without existing user' do
      it 'returns errors' do
        post '/api/v1/users/login', { email: 'foobar@example.com', password: 'password' }

        expect(json_body['errors']).to eq('incorrect Email or Password')
      end
    end
  end
end
