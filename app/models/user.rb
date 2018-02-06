class User < ActiveRecord::Base
  extend Slugible
  has_secure_password
  has_many :pets

  def slug
    self.username.downcase.gsub(/\s/,'-')
  end
end
