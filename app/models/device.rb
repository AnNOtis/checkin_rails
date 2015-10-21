class Device < ActiveRecord::Base
  # default scope

  # constant

  # attr macros

  # association macros
  belongs_to :user

  # validation macros
  validates :device_token, presence: true, uniqueness: { scope: :user_id }

  # callback macros

  # other macros

  # scope macros
end
