CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  elsif Rails.env.development?
    config.storage = :file
    config.enable_processing = true
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['ACCESS_KEY_ID'],         # required
      :aws_secret_access_key  => ENV['SECRET_ACCESS_KEY'],     # required
    }

    config.fog_public     = true                               # optional, defaults to true
    config.fog_directory  = 'artlab'                           # required
  end
end
