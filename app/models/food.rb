class Food < ActiveRecord::Base
  belongs_to :category

  def slug
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|food| food.slug == slug}
  end

  def first_pronoun
    if self.name[-1] == "s"
      "were"
    else
      "was"
    end
  end

  def second_pronoun
    if self.name[-1] == "s"
      "them"
    else
      "it"
    end
  end

  def expired?
    self.expiration_date == Date.today.strftime
  end

  def date_splitter
    date_array = self.expiration_date.split("-")
    date_array.collect {|date| date.to_i}
  end

  def almost_expired?
    self.date_splitter[0] == Time.now.year && self.date_splitter[1] == Time.now.month && Time.now.day < self.date_splitter[2] && self.date_splitter[2] - Time.now.day <= 2
  end

  def days_until_expiration
    "#{self.date_splitter[2] - Time.now.day} days."
  end

end
