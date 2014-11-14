 class CategoriesController < ApplicationController
     before_action :require_user, except: [:show, :index]

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create

    @categories = Category.all
    @category = Category.new(category_params)
    if @category.save
    flash[:notice] = "You created a category suscessfully."
    redirect_to root_path
    else
    render :new
    end  
  end

  def show
    @category = Category.find (params[:id])    
  end

private
  def category_params
    params.require(:category).permit!
  end

end