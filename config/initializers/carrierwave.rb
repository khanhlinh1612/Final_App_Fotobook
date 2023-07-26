CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'YOUR_AWS_ACCESS_KEY_ID',
    aws_secret_access_key: 'YOUR_AWS_SECRET_ACCESS_KEY',
    region: 'us-east-1' # Change this to your desired AWS region
  }
  config.fog_directory = 'your-bucket-name'
end
