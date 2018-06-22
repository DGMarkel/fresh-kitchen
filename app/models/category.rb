class Category < ActiveRecord::Base
  belongs_to :user
  has_many :foods

  def slug
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|category| category.slug == slug}
  end

  def almost_expired_foods
    self.foods.select {|food| food.almost_expired?}
  end

end
