class User < ActiveRecord::Base
  # default scope

  # constant

  # attr macros

  # association macros
  has_many :devices

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
end
