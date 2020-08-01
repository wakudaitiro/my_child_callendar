VCR.configure do |config|
  config.filter_sensitive_data('<SECRET_KEY>') { ENV['SOME_SECRET_KEY'] }
end