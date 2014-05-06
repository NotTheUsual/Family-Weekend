require 'data_mapper'
require_relative 'lib/family_weekend'

task :auto_upgrade do
  DataMapper.auto_upgrade!
  puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do
  DataMapper.auto_migrate!
  puts "Auto-migrate complete (data could have been lost)"
end

task :carrierwave_setup do
  CarrierWave.configure do |config| 
    config.root = "#{Dir.pwd}/public/" 
  end
end