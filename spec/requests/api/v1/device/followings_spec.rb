require 'rails_helper'
require 'shared_contexts'

RSpec.describe '/api/v1/device/followings' do
  include_context 'api request authentication helper methods'
  include_context 'api request global before and after hooks'

  describe 'POST /api/v1/device/followings/:id' do

    it 'creates following record' do
      follower = sign_in(create(:user))
      following = create(:user, email: 'XXX@gmail.com')

      post "/api/v1/device/followings/#{following.id}"

      expect(follower.followins).to include(following)
      expect(following.followers).to include(follower)
    end
  end
end
