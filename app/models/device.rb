class Device < ActiveRecord::Base
  # default scope

  # constant

  # attr macros

  # association macros
  belongs_to :user

  # validation macros
  validates :device_token, presence: true, uniqueness: true

  # callback macros

  # other macros

  # scope macros

  def ensure_device_token
    if device_token.blank?
      self.device_token = generate_token
    end
  end

  private

  def generate_token
    loop do
      token = Devise.friendly_token
      break token unless Device.find_by(device_token: token)
    end
  end
end
