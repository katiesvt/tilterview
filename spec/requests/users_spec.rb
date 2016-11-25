require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user/:id" do
    it "returns 200 for valid user" do
      id = 1

      get users_path(id)
      expect(response).to have_http_status(200)
    end

    it "returns 404 for invalid user" do
      id = 2

      get users_path(id)
      expect(response).to have_http_status(404)
    end
  end
end
