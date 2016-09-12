class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  # Lists all tweets
  def send_message
    # Include the helper gateway class
    require './AfricasTalkingGateway'
    # Specify your login credentials
    username = "b-mwenda";
    apikey   = "4427406fe6c4d0f47424c2b3d0960cf3d982fcb2e7227b13f3f94696b3980cfe";
    # Specify the numbers that you want to send to in a comma-separated list
    # Please ensure you include the country code (+254 for Kenya in this case, +256 for Uganda)
    to      = "+254772376746";
    # And of course we want our recipients to know what we really do
    message = "Murrrder is coming your way"
    # Create a new instance of our awesome gateway class
    gateway = AfricasTalkingGateway.new(username, apikey)
    # Any gateway error will be captured by our custom Exception class below,
    # so wrap the call in a try-catch block
    begin
      # Thats it, hit send and we'll take care of the rest.
      reports = gateway.sendMessage(to, message)
      
      reports.each {|x|
        # status is either "Success" or "error message"
        puts 'number=' + x.number + ';status=' + x.status + ';messageId=' + x.messageId + ';cost=' + x.cost
      }
    rescue AfricasTalkingGatewayException => ex
      puts 'Encountered an error: ' + ex.message
    end
    # DONE!
  end

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
