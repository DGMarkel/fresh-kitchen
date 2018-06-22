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
    self.expiration_date.split
  end

  def almost_expired?
  end  








=begin
        <!--<% almost_expired = current_user.foods.select do |food| %>
          <% date_array = food.expiration_date.split("-") %>
          <% Date.today.strftime.month == date_array[1] && Date.today.strftime.day > date_array[3] &&
            Date.today.strftime.day - date_array[3] < 2 %>
        -->
=end
end
