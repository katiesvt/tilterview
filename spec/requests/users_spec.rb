require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user/:user_id" do
    let(:default_headers) { {
      params: { format: :json },
      headers: { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Settings.auth.name, Settings.auth.password) }
    } }

    def get_user(user: "katiesvt")
      get user_path(user), default_headers
    end

    it "returns user given valid id" do
      get_user
      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("users/show")
    end

    it "returns 404 given invalid user" do
      get_user(user: 404)
      expect(response).to have_http_status(404)
    end

    it "returns 404 given suspended user" do
      get_user(user: 403)
      expect(response).to have_http_status(403)
    end

    it "returns 429 when rate limited" do
      get_user(user: 429)
      # Apparently the twitter gem likes to throw the old EnhanceYourCalm error which corresponds to
      # HTTP status 420. They mean the same thing, just one is an old joke.
      expect(response).to have_http_status(420)
    end
  end
end
