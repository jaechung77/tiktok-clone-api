CarrierWave.configure do |config|
    config.root = Rails.root.join('tmp') # adding these...
    config.cache_dir = 'carrierwave' # ...two lines
    config.fog_credentials = {
      provider:              'AWS',                            # required
      aws_access_key_id:     ENV["AWS_ACCESS_KEY"],            # required
      aws_secret_access_key: ENV["AWS_SECRET_KEY"],            # required
      region:                'us-east-1'                       # to match the carrierwave and bucket region
    }
    config.fog_directory = ENV["AWS_BUCKET"]                   # required
    config.fog_public    = true
    config.cache_dir     = "#{Rails.root}/tmp/uploads"         # To let CarrierWave work on Heroku
    config.storage       = :fog
  
  end