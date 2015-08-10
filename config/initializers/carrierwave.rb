# if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    # config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Settings.aws.access_key_id,
      aws_secret_access_key: Settings.aws.secret_access_key,
      region:                Settings.aws.s3_bucket_region,
    }
    config.fog_directory  = Settings.aws.s3_bucket_name
    config.fog_public     = false
    # config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
# else
#   CarrierWave.configure do |config|
#     config.storage = :file
#   end
# end
