class Food < ActiveRecord::Base
  belongs_to :category

  def slug
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|food| food.slug == slug}
  end

end
