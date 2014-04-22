env = ENV['RACK_ENV'] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/stern_#{env}")

CarrierWave.configure { |config| config.root = "#{Dir.pwd}" }

require_relative 'uploaders/image_uploader'
Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!