class Tweet < ActiveRecord::Base
	# Associations
  belongs_to :user
end
