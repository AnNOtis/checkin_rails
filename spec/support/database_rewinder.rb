RSpec.configure do |config|
  config.use_transactional_fixtures = false
  
  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :each do
    DatabaseRewinder.clean
  end
end
