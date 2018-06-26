class FoodController < ApplicationController

  get '/users/:user_slug/foods/new' do
    if logged_in?
      erb :'/foods/create_food'
    else
      redirect to :/
    end
  end

  post '/users/:user_slug/foods' do
    food = Food.create(params[:food])
    if !params[:category][:id].empty?
        food.update(category_id: params[:category][:id])
        redirect:"/users/#{current_user.slug}/#{food.category.slug}"
    elsif !params[:category][:name].empty? && !current_user.categories.find_by(name: params[:category][:name])
      category_new = Category.create(name: params[:category][:name], user_id: current_user.id)
      food.update(category_id: category_new.id)
    else
      redirect :"/users/#{current_user.slug}/foods/new"
    end
    redirect:"/users/#{current_user.slug}/#{food.category.slug}"
  end

  get '/users/:user_slug/:category' do
    if logged_in?
      category_id = current_user.categories.find_by_slug(params[:category]).id
      @foods = current_user.foods.select {|food| food.category_id == category_id}
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
    if !params[:update][:category].empty? && params[:new][:category].empty?
      @food.update(category_id: params[:update][:category].to_i)
      redirect "/users/#{current_user.slug}/@food.slug}"
    elsif !params[:update][:new_category].empty? && params[:update][:existing_category].empty? && !current_user.categories.find_by(params[:update][:new_category])
      category_new = Category.create(name: params[:new][:category], user_id: current_user.id)
      @food.update(category_id: category_new.id)
      redirect "/users/#{current_user.slug}/#{category_new.name}"
    else
      redirect :"/users/#{current_user.slug}/#{@food.category.slug}"
    end
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

end
