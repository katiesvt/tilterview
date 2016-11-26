class UsersController < ApplicationController
  def show
    safely_twitter do
      @user = User.find(params[:id], fetch: true)
      render json: @user
    end
  end
end
