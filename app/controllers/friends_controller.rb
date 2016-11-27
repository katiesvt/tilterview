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
  rescue InvalidFilterError
    head 422
  end

  def restrict_by_user_id(full_set)
    if params[:restrict_by_user_id].try(:to_i) && params[:restrict_by_user_id].to_i > 0
      filter_set = User.find(params[:restrict_by_user_id].to_i).friend_ids
      full_set & filter_set
    else
      raise InvalidFilterError
    end
  end
end
