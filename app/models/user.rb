class User < ActiveRecord::Base
  attr_reader :password

  def password= password
    self.passwordDigest = BCrypt::Password.create(password)
    @password = password
  end

  def self.find_by_credentials username, password
    user = User.find_by(username: username)
    return nil unless user
    user.password_is?(password) ? user : nil
  end

  def password_is? password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
