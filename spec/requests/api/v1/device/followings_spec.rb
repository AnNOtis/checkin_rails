require 'rails_helper'
require 'shared_contexts'

RSpec.describe '/api/v1/device/followings' do
  include_context 'api request authentication helper methods'
  include_context 'api request global before and after hooks'

  describe 'POST /api/v1/device/followings' do
    it 'creates following record' do
      follower = create(:user)
      following = create(:user)
      
      sign_in(follower)

      post '/api/v1/device/followings', following_id: following.id

      expect(follower.followings.last.id).to eq(following.id)
      expect(following.followers.last.id).to eq(follower.id)
    end
  end
end
