require 'rails_helper'
RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#follow' do
    context "when the following didn't followed by current user"  do
      it 'creates following relationship and turn following user' do
        follower = create(:user)
        following = create(:user)

        expect(follower.follow(following)).to eq(following)
        expect(follower.followings.last.id).to eq(following.id)
        expect(following.followers.last.id).to eq(follower.id)
      end
    end
    context "when the following followed by current user"  do
      it 'returns nil' do
        follower = create(:user)
        following = create(:user)
        follower.follow(following)

        expect(follower.follow(following)).to be_nil
      end
    end
  end
end
