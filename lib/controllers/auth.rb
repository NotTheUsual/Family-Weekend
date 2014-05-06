require_relative 'base'

class AuthenticationController < Base
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
end