require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, unique: true, message: "This name is already taken"
  property :password_digest, Text
  property :admin, Boolean

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(name, password)
    maker = first(name: name)
    if maker && BCrypt::Password.new(maker.password_digest) == password
      maker
    end
  end
end