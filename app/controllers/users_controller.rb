class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.find(params[:id])
    if @user.save
    flash[:notice] = "You created a user suscessfully."
    redirect_to root_path
    else
    render :new
    end  
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    if params[:id] 
      @user=User.find(params[:id]) 
    else
      @user= current_user
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
    flash[:notice] = "You updated a user suscessfully."
    redirect_to root_path
    else
    render :edit
    end
  end

private
  def user_params
    params.require(:user).permit!
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You are not allowed to do that."
      redirect_to root_path      
    else
          
    end    
  end
end