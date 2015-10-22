require 'rails_helper'

RSpec.describe '/api/v1/registrations' do
  describe 'POST register user' do
    def do_request
      post '/api/v1/registrations', params
    end

    context 'with existing user' do
      let(:user_attributes) { attributes_for(:user) }
      let(:params) { Hash(device_token: 'token').merge!(user_attributes) }

      before { User.create(user_attributes) }

      it 'renders correctly' do
        do_request

        expect(json_body['user']['email']).to eq(user_attributes[:email])
        expect(response).to have_http_status(201)
      end
    end

    context 'without existing user' do
      context 'with correct user info' do
        let(:user_attributes) { attributes_for(:user) }
        let(:params) { Hash(device_token: 'token').merge!(user_attributes) }

        it 'renders correctly' do
          do_request

          expect(json_body['user']['email']).to eq(user_attributes[:email])
          expect(response).to have_http_status(201)
        end
      end

      context 'with incorrect user info' do
        let(:user_attributes) { attributes_for(:user, :invalid) }
        let(:params) { Hash(device_token: 'token').merge!(user_attributes) }

        it 'renders correctly' do
          do_request

          expect(json_body['errors']).to be_present
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
