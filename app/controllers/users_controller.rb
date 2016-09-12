class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  def show
  	@user = User.find(params[:id])
  	@tweets = Tweet.where(user_id: params[:id])
  end

  def index
  	@users = User.all
  end

  def create
  	@user = User.new(user_params)
  	@user.save
  	redirect_to @user
  end

  def edit
  end

  def new
  	@user = User.new
  end

  def update
  	@user.update(user_params)
  	redirect_to @user
  end

  def destroy
  	@user.destroy
  	redirect_to users_url
  end

  def set_user
  	@user = User.find(params[:id])
  end

  def user_params
  	params.require(:user).permit(:username, :gender, :date_of_birth, :bio, :email)
  end
end
