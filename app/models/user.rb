class User < ActiveRecord::Base
  include Slugible::InstanceMethods
  extend Slugible::ClassMethods
  has_secure_password
  has_many :pets
end
