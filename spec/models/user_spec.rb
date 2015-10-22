require 'rails_helper'
RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe ".find_or_initialize_with" do
    let(:user) { User.find_or_initialize_with(info_params) }

    context "user not exists" do
      let(:info_params) { Hash(email: "foo@example.com") }

      it "initializes a new user" do
        expect(user.email).to eq "foo@example.com"
        expect(user).not_to be_persisted
      end
    end

    context "user exists" do
      let(:info_params) { Hash(email: "foo@example.com") }

      before do
        create(
          :user,
          email: "foo@example.com",
          password: "password",
          password_confirmation: "password"
        )
      end

      context "with invalid password" do
        it "appends error to user" do
          expect(user.errors[:base]).to eq [{ message: "email or password not correct" }]
        end
      end

      context "with valid password" do
        let(:info_params) { Hash(email: "foo@example.com", password: "password") }

        it "returns the exiting user" do
          expect(user).to be_present
          expect(User).not_to receive(:new)
        end
      end
    end
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
