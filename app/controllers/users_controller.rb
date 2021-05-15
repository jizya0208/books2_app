class UsersController < ApplicationController
  
  # def new
  #   @user = User.new
  # end
  
  # def create
  #   @user = User.new(user_params)
  #   @user.save
  # end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
