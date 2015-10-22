class User < ActiveRecord::Base
  # default scope

  # constant

  # attr macros

  # association macros
  has_many :devices
  has_many :checkins

  has_many :follower_relationships,
    class_name:  'FollowerFollowingShip',
    foreign_key: 'following_id',
    dependent:   :destroy
  has_many :following_relationships,
    class_name:  'FollowerFollowingShip',
    foreign_key: 'follower_id',
    dependent:   :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :followings, through: :following_relationships, source: :following

  # validation macros
  validates :name, presence: true, uniqueness: true

  # callback macros

  # other macros
  # =>  Include default devise modules. Others available are:
  # =>  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # scope macros

  def self.authenticate(username, password)
    user = User.find_for_authentication(:username => username)
    user.valid_password?(password) ? user : nil
  end

  def follow!(following)
    followings << following
  end

  def follow(following)
    follow!(following)
    following
  rescue
    nil
  end
end
