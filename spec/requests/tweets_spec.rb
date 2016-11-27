require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /user/:user_id/tweets" do
    let(:default_user_id) { 297789562 }

    let(:default_headers) { {
      params: { format: :json },
      headers: { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Settings.auth.name, Settings.auth.password) }
    } }

    def get_tweets(user: default_user_id)
      get user_tweets_path(user), default_headers
    end

    it "returns tweets given valid id" do
      get_tweets
      expect(response).to have_http_status(200)

      # This works as a sanity check for now but will likely fail when validating a different user
      # as I haven't gone through the schema and marked the multi-type fields as such and also
      # excluded the "required" fields from "required". Leaving it as a TODO to robustify this in
      # the future.
      expect(response).to match_json_schema("tweets/index")
    end

    it "returns 404 given invalid user id" do
      get_tweets(user: 404)
      expect(response).to have_http_status(404)
    end

    it "returns 404 given restricted user id" do
      get_tweets(user: 401)
      expect(response).to have_http_status(401)
    end

    it "returns 429 when rate limited" do
      get_tweets(user: 429)
      # Apparently the twitter gem likes to throw the old EnhanceYourCalm error which corresponds to
      # HTTP status 420. They mean the same thing, just one is an old joke.
      expect(response).to have_http_status(420)
    end

    it "raises error with malformed JSON" do
      # No specific error class in the gem for malformed JSON.
      expect{get_tweets(user: -1)}.to raise_error Twitter::Error
    end
  end
end
