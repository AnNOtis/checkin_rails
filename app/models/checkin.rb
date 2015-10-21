class Checkin < ActiveRecord::Base
  # default scope

  # constant

  # attr macros

  # association macros
  belongs_to :user

  # validation macros
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  # callback macros

  # other macros

  # scope macros
end
