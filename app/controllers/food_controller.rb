class FoodController < ApplicationController

  get '/users/:user_slug/foods/new' do
    if logged_in?
      erb :'/foods/create_food'
    else
      redirect to :/
    end
  end

  post '/users/:user_slug/foods' do
    @food = Food.create(params[:food])

    ####conditions for creating/associating categories to foods####

    #if any field is empty
    if params[:food].any? {|k, v| v == ""}
      redirect :"/users/#{current_user.slug}/foods/new"
    else
    #if an existing category is selected
      if params[:category][:id]
        @food.update(category_id: params[:category][:id])
    #if a new category is entered and its name < 50% similar to existing category names
      elsif !params[:category][:name].empty? && !find_similar_category_by_name_for_create
        category_new = Category.create(name: params[:category][:name].downcase.capitalize, user_id: current_user.id)
        @food.update(category_id: category_new.id)
    #if a new category is entered and its name > %50 similar to existing category names
      elsif !params[:category][:name].empty? && find_similar_category_by_name_for_create
        @food.update(category_id: find_similar_category_by_name_for_create.id)
      end
      category = current_user.categories.find_by(id: @food.category_id)
      redirect to :"/users/#{current_user.slug}/#{category.slug}"
    end

  end

  get '/users/:user_slug/:category' do
    if logged_in?
      category_id = current_user.categories.find_by_slug(params[:category]).id
      @foods = current_user.foods.where(category_id: category_id)
      erb :'/foods/show_food_by_category'
    else
      redirect :/
    end
  end

  get '/users/:user_slug/:category/:food/edit' do
    if logged_in?
      @food = current_user.foods.find_by_slug(params[:food])
      erb :'/foods/edit_food'
    else
      redirect :/
    end
  end

  post '/users/:user_slug/:category/:food' do
    @food = current_user.foods.find_by_slug(params[:food])
    @food.update(params[:update])

    ####conditions for editing/associating foods categories####
    #if a new category is entered and no existing category names are >= %50 similar
    if !params[:new][:category].empty? && !find_similar_category_by_name_for_edit
      category_new = Category.create(name: params[:new][:category].downcase.capitalize, user_id: current_user.id)
      @food.update(category_id: category_new.id)
    #if a new category is entered and an existing category name is >= %50 similar
    elsif !params[:new][:category].empty? && find_similar_category_by_name_for_edit
      @food.update(category_id: find_similar_category_by_name_for_edit.id)
    end
    redirect :"/users/#{current_user.slug}/#{params[:category]}"
  end

  get '/users/:user_slug/:category/:food/delete' do
    if logged_in?
      food = current_user.foods.find_by_slug(params[:food])
      food.delete
      redirect :"/users/#{current_user.slug}/#{params[:category]}"
    else
      redirect :/
    end
  end

  helpers do

    # for post '/users/:user_slug/foods'
    def find_similar_category_by_name_for_create
      current_user.categories.find {|category| category.name.similar(params[:category][:name]) >= 50}
    end

    #for post '/users/:user_slug/:category/:food'
    def find_similar_category_by_name_for_edit
      current_user.categories.find {|category| category.name.similar(params[:new][:category]) >= 50}
    end

  end

end
