require 'rails_helper'
RSpec.describe "Blogs", type: :request do
  describe "GET /blogs" do
    it "returns http success" do
      get "/blogs"
      expect(response).to have_http_status(:success)
    end
    it "returns JSON list of published blogs" do
      Blog.create(title: "Test", body: "Body", published: true)
      get "/blogs.json"
      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json.length).to be >= 1
    end
  end
end
