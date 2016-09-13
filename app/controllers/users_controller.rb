class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

  def send_message_without_id
    # Include Africa's Talking helper gateway class
    # require 'AfricasTalkingGateway'
    # Specify login credentials
    username = "b-mwenda";
    apikey   = "4427406fe6c4d0f47424c2b3d0960cf3d982fcb2e7227b13f3f94696b3980cfe";
    # Specify the numbers that you want to send to in a comma-separated list
    # Please ensure you include the country code (+254 for Kenya in this case, +256 for Uganda)
    to      = "+254715300570";
    # And of course we want our recipients to know what we really do
    message = "Testing API"
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

  def send_message
    # Sending Messages using sender id/short code
    require 'AfricasTalkingGateway'
    username = "b-mwenda";
    apikey   = "4427406fe6c4d0f47424c2b3d0960cf3d982fcb2e7227b13f3f94696b3980cfe";
    to      = "+254715300570";
    message = "Ume Saskia Saikle?"
    # Specify your AfricasTalking shortCode or sender id
    sender = "Saikle"
    gateway = AfricasTalkingGateway.new(username, apikey)
    begin
      # Thats it, hit send and we'll take care of the rest.
      reports = gateway.sendMessage(to, message, sender)
      
      reports.each {|x|
        puts 'number=' + x.number + ';status=' + x.status + ';messageId=' + x.messageId + ';cost=' + x.cost
      }
    rescue AfricasTalkingGatewayException => ex
      puts 'Encountered an error: ' + ex.message
    end
    # DONE!
  end

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
