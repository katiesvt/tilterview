require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /user/:id/tweets" do
    it "returns 200" do
      # TODO stub this?
      get user_tweets_path(1)

      expect(response).to have_http_status(200)
    end
  end
end
