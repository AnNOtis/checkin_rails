require 'rails_helper'
RSpec.describe Device do
  it { is_expected.to validate_presence_of(:device_token) }
  it { is_expected.to validate_uniqueness_of(:device_token).scoped_to(:user_id) }
end
