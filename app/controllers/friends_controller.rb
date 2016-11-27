class FriendsController < ApplicationController
  class InvalidFilterError < StandardError; end

  def index
    safely_twitter do
      @friends = if params[:restrict_by_user_id]
        restrict_by_user_id(current_user.friend_ids)
      else
        current_user.friend_ids
      end

      render json: @friends
    end
  rescue ArgumentError
    head 422
  end

  def restrict_by_user_id(full_set)
    if Integer(params[:restrict_by_user_id]) > 0
      filter_set = User.find(Integer(params[:restrict_by_user_id])).friend_ids
      full_set & filter_set
    else
      raise ArgumentError
    end
  end
end
