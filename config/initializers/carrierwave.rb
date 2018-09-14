CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJ7DNBYJZMOMQJPFQ',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }
  
  config.fog_directory  = 'amazon-s3-rails-image'
  config.cache_storage = :fog
end