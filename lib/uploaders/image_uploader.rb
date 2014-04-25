class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if ENV['RACK_ENV'] == 'production' 
    storage :fog
  else 
    storage :file 
  end 
 
  def store_dir 
    if ENV['RACK_ENV'] == 'production' 
      "uploads/image"
    else 
      "public/uploads/image"
    end 
  end 
 
  def extensions_white_list 
    %w(jpg jpeg gif png) 
  end 

  version :thumb do
    process resize_to_fit: [300,300]
  end
end