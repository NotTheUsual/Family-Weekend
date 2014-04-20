require 'data_mapper'
require 'sinatra/base'
require 'haml'

env = ENV['RACK_ENV'] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/stern_#{env}")

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!

require_relative 'helpers/app'

class FamilyWeekend < Sinatra::Base
  set :public_folder, File.join(File.dirname(__FILE__), '../public')
  
  helpers AppHelpers

  get '/' do
    haml :index
  end

  get '/history' do
    haml :history
  end

  get '/next-year' do
    haml :next_year
  end

  get '/login' do
    haml :login
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
