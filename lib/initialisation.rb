env = ENV['RACK_ENV'] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/stern_#{env}")

CarrierWave.configure do |config|
  config.root = "#{Dir.pwd}"
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['aws_access_key_id'],
    :aws_secret_access_key  => ENV['aws_secret_access_key'],
    :region                 => 'eu-west-1'
  }
  config.fog_directory  = ENV['s3_bucket_name']                     # required
end

require_relative 'uploaders/image_uploader'
Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!