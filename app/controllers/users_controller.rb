class UsersController < ApplicationController
  def show
  	# @me = User.find(params[:id])
  	@users = User.all
  end

  def index
  	@users = User.all
  end
end
