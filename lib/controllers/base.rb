require_relative '../helpers/app'

class Base < Sinatra::Base
  use Rack::MethodOverride

  enable :sessions
  set :session_secret, ENV['session_secret']
  
  set :public_folder, File.join(File.dirname(__FILE__), '../public')
  set :views, File.join(File.dirname(__FILE__), '../views')

  helpers AppHelpers

  private

  def redirect_if_logged_out
    redirect to('/login') unless session[:user_id]
  end
end