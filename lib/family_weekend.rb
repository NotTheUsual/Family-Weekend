require 'data_mapper'
require 'sinatra/base'
require 'haml'
require 'json'
require 'carrierwave/datamapper'
require 'word-to-markdown'

require_relative 'initialisation'

env = ENV['RACK_ENV'] || "development"

require 'pry' if env == 'development'

require_relative 'helpers/app'

Dir.glob(File.join(File.dirname(__FILE__), 'controllers', '*.rb'), &method(:require))

class FamilyWeekend < Sinatra::Base
  enable :sessions
  set :session_secret, ENV['session_secret']
  use Rack::MethodOverride
  set :public_folder, File.join(File.dirname(__FILE__), '../public')
  
  helpers AppHelpers

  get('/')          { StaticPagesController.call(env) }
  get('/history')   { StaticPagesController.call(env) }
  get('/next-year') { StaticPagesController.call(env) }
  get('/video')     { StaticPagesController.call(env) }
  get('/survey')    { StaticPagesController.call(env) }

  get('/photos')     { PhotosController.call(env) }
  post('/photos')    { PhotosController.call(env) }
  get('/photos/new') { PhotosController.call(env) }
  get('/photos/:id') { PhotosController.call(env) }

  get('/login')       { AuthenticationController.call(env) }
  post('/sessions')   { AuthenticationController.call(env) }
  delete('/sessions') { AuthenticationController.call(env) }

  get('/news/manage')   { NewsController.call(env) }
  get('/news/add')      { NewsController.call(env) }
  post('/news/convert') { NewsController.call(env) }
  post('/news')         { NewsController.call(env) }
  get('/news/:id')      { NewsController.call(env) }
  get('/news/:id/edit') { NewsController.call(env) }
  get('/news/:id/json') { NewsController.call(env) }


  # start the server if ruby file executed directly
  run! if app_file == $0
end
