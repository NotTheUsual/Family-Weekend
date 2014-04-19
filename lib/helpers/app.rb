module AppHelpers
  def nav_class_for(path)
    current?(path) ? 'current' : ''
  end

  def current?(path)
    request.path_info == '/' + path
  end
end