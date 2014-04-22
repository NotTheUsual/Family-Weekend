require_relative 'base'

class PhotosController < Base
  get '/photos' do
    if session[:user_id]
      @photos = Photo.all
      haml :photos
    else
      redirect to('/login')
    end
  end

  post '/photos' do
    Photo.create(photo_params)
    redirect to('/photos')
  end

  get '/photos/new' do
    haml :"photos/new"
  end

  get '/photos/:id' do |id|
    @photo = Photo.get(id)
    haml :"photos/show"
  end

  private
  
  def photo_params
    {image: params[:photo], year: params[:year]}
  end
end