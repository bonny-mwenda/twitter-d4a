class TweetsController < ApplicationController
  def show
  	@tweets = Tweet.all
  end

  def profile
  	@profile = Tweet.find(params[:id])
  end
end
