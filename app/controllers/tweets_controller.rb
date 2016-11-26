class TweetsController < ApplicationController
  def index
    safely_twitter do
      @tweets = current_user.tweets
      render json: @tweets
    end
  end

  private

  def current_user
    @current_user ||= User.find(params[:user_id])
  end
end
