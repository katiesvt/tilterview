require 'rails_helper'

RSpec.describe "Friends", type: :request do
  let(:default_headers) { {
    params: { format: :json },
    headers: { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Settings.auth.name, Settings.auth.password) }
  } }

  describe "GET /user/:user_id/friends" do
    it "returns valid json" do
      get user_friends_path("katiesvt"), default_headers
      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("friends/index")
    end

    it "returns valid json for someone with no friends" do
    end

    context "with restrict_by_user_id param" do
      def get_friend_intersect(id_b, parse: true)
        get user_friends_path("katiesvt"), default_headers.merge(params: { restrict_by_user_id: id_b })

        JSON.parse(response.body) if parse
      end

      it "returns empty set when no friends in common" do
        json = get_friend_intersect("realDonaldTrump")

        expect(response).to have_http_status(200)
        expect(json).to be_an(Array)
        expect(json).to be_empty
      end

      it "returns friends common to both users" do
        json = get_friend_intersect("jimSterling")

        expect(response).to have_http_status(200)
        expect(json).to be_an(Array)
        expect(json).not_to be_empty
      end

      it "returns empty set when user B has no friends" do
        json = get_friend_intersect(9999)

        expect(response).to have_http_status(200)
        expect(json).to be_an(Array)
        expect(json).to be_empty
      end

      it "returns error with not found user B id" do
        # TODO change to proper error
        get_friend_intersect("404im_a_bad_wittle_screen_name", parse: false)

        expect(response).to have_http_status(404)
      end

    end
  end
end
