class Pet < ActiveRecord::Base
  extend Slugible
  belongs_to :user

  def slug
    self.name.downcase.gsub(/\s/,'-')
  end
end
