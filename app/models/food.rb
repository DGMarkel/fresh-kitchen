class Food < ActiveRecord::Base
  belongs_to :user

  def food_slug
    self.name.gsub(" ", "-")
  end

  def self.find_by_food_slug(slug)
    self.all.find {|user| user.slug == slug}
  end

end
