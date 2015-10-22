class FollowerFollowingShip < ActiveRecord::Base
  belongs_to :follower, class_name: User
  belongs_to :following, class_name: User
  validates :follower, uniqueness: { scope: :following_id }
  validates :following, uniqueness: { scope: :follower_id }
end
