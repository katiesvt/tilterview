class TweetsController < ApplicationController
  def index
    safely_twitter do
      @tweets = current_user.tweets
      render json: @tweets
    end
  end
end
