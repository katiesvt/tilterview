require 'sinatra/base'

class FakeTwitter < Sinatra::Base

  # Used by User#tweets
  get '/1.1/statuses/user_timeline.json' do
    # If you give an HTTP status code instead of an ID, we'll simulate the error of that number.
    status_returned = 200
    status_returned = params[:user_id].to_i if params[:user_id].to_i < 1000

    json_response status_returned, "1.1/statuses/user_timeline/#{params[:user_id]}"
  end

  # Used by User
  get '/1.1/users/show.json' do
    status_returned = 200
    status_returned = params[:user_id].to_i if params[:user_id].to_i < 1000
    json_response status_returned, "1.1/users/show/#{params[:user_id]}"
  end

  get '/1.1/friends/list.json' do
    status_returned = 200
    status_returned = params[:user_id].to_i if params[:user_id].to_i < 1000
    json_response status_returned, "1.1/friends/list/#{params[:user_id]}"
  end

  get '/1.1/statuses/show/:id.json' do
    status_returned = 200
    status_returned = params[:id].to_i if params[:id].to_i < 1000
    json_response status_returned, "1.1/statuses/show/#{params[:id]}"
  end

  private

  def json_response(response_code, file_name)
    cursor_path = params[:cursor].try(:to_i) && params[:cursor].to_i > 0 ? "_#{params[:cursor]}" : ""
    json_path = File.dirname(__FILE__) + "/fixtures/" + file_name + cursor_path + ".json"

    unless File.exists?(json_path)
      status 500
      return "Couldn't find JSON #{json_path}"
    end

    content_type :json
    status response_code

    File.open(json_path, "rb")
  rescue StandardError => ex
    status 500
    ex.message
  end
end