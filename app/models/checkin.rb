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
  # => Address is automatically fetched and saved from lat and lng
  after_validation :reverse_geocode

  # other macros
  reverse_geocoded_by :latitude, :longitude

  mount_uploader :photo, PhotoUploader
  # scope macros
  scope :newest_first, -> { order(created_at: :desc) }
end
