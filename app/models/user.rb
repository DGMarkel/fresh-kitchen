class User < ActiveRecord::Base
  has_secure_password
  has_many :categories
  has_many :foods, through: :categories

  def valid_password?
  end

  def user_slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_user_slug(slug)
    self.all.find {|user| user.slug == slug}
  end

  def expired_foods
    self.foods.select {|food| food.expired?}
  end

  def almost_expired_foods
    self.foods.select {|food| food.almost_expired?}
  end

end
