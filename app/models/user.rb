class User < ActiveRecord::Base
  # default scope

  # constant

  # attr macros

  # association macros

  # validation macros
  validates :name, presence: true, uniqueness: true

  # callback macros

  # other macros
  # =>  Include default devise modules. Others available are:
  # =>  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # scope macros
end
