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
  enable :sessions
  set :session_secret, ENV['session_secret']
  use Rack::MethodOverride
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

  get '/photos' do
    if session[:user_id]
      haml :photos
    else
      redirect to('/login')
    end
  end

  get '/login' do
    haml :login
  end

  post '/sessions' do
    name, password = params[:name], params[:password]
    user = User.authenticate(name, password)
    if user
      session[:user_id] = user.id
      redirect to('/photos')
    else
      redirect to('/login')
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
