require 'rails_helper'

RSpec.describe "Targets", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/target/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/target/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/target/new"
      expect(response).to have_http_status(:success)
    end
  end

end
