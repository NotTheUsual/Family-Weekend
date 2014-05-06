class Photo
  include DataMapper::Resource

  property :id, Serial
  property :year, Integer

  mount_uploader :image, ImageUploader
end