CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     'AKIAWAMUVFXO67TTCG2W',                        # required
      aws_secret_access_key: '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',                        # required
      region:                'us-east-1',             # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = 'tt-clone-rails-api-v2'            # required
  end