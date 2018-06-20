class User < ActiveRecord::Base
  has_secure_password
  has_many :vegetables
  has_many :meats
  has_many :beverages
  has_many :pantry_items
  has_many :fruits
end
