class UsersController < ApplicationController
  def show
    safely_twitter do
      @user = User.find_by_screen_name(params[:id], fetch: true)
      render json: @user
    end
  end
end
