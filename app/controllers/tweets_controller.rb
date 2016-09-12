class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  # Lists all tweets
  def index
    # Get the user who posted the tweet
  	@user = User.find(params[:user_id])
  	@tweets = Tweet.where(user_id: params[:user_id])
  end

  def all_tweets
    @all_tweets = Tweet.all
  end

  # show a tweet
  def show
    @user = User.find(params[:user_id])
  end

  def new
  @user = User.find(params[:user_id])
  @tweet = Tweet.new
  end

  def edit
  end

  # create a new tweet
  def create
    @user = User.find(params[:user_id])
    @tweet = @user.tweets.create(tweet_params)
    redirect_to user_tweets_path
  end

  def update
    @user = User.find(params[:user_id])
    @tweet = @user.tweets.update(tweet_params)
    redirect_to user_tweets_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @tweet = @user.tweets.find(params[:id])
    @tweet.destroy
    redirect_to tweets_url
  end

  def set_tweet
    @user = User.find(params[:user_id])
    @tweet = @user.tweets.find(params[:id])
  end

  # protect our data from malicious peeps
  private
  def tweet_params
  	params.require(:tweet).permit(:status)
  end
end
