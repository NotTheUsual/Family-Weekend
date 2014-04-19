require 'sinatra/base'

require_relative 'helpers/app'

class FamilyWeekend < Sinatra::Base
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
