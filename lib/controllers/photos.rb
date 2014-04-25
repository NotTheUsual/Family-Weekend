require_relative 'base'

class PhotosController < Base
  get '/photos' do
    redirect_if_logged_out
    @photos = Photo.all
    haml :photos
  end

  post '/photos' do
    Photo.create(photo_params)
    redirect to('/photos')
  end

  get '/photos/new' do
    redirect_if_not_admin
    haml :"photos/new"
  end

  get '/photos/:id' do |id|
    redirect_if_logged_out
    @photo = Photo.get(id)
    haml :"photos/show"
  end

  private
  
  def photo_params
    { image: params[:photo], year: params[:year] }
  end
end