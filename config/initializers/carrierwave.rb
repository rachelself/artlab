CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  elsif Rails.env.development?
    config.storage = :file
    config.enable_processing = true
  else
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],        # required
      :aws_secret_access_key  => ENV['AWS_ACCESS_SECRET'],     # required
    }
    config.storage = :fog
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_directory  = 'name_of_directory'                     # required
  end
end
