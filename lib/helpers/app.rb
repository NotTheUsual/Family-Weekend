module AppHelpers
  def nav_class_for(path)
    current?(path) ? 'current' : ''
  end

  def current?(path)
    request.path_info == '/' + path
  end

  def current_user    
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

  def thumb_url(photo)
    photo.image.thumb.url.gsub('/public', '')
  end

  def full_url(photo)
    photo.image.url.gsub('/public', '')
  end
end