require_relative 'base'

class StaticPagesController < Base
  get '/' do
    haml :index
  end

  get '/history' do
    haml :history
  end

  get '/next-year' do
    haml :next_year
  end

  get '/video' do
    redirect_if_logged_out
    haml :video
  end

  get '/survey' do
    redirect_if_logged_out
    haml :survey
  end
end