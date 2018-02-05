class Pet < ActiveRecord::Base
  include Slugible::InstanceMethods
  extend Slugible::ClassMethods
  belongs_to :user
end
