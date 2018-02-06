module Slugible

  def find_by_slug(slug)
    self.all.detect do |instance|
      instance.slug == slug
    end
  end

end
