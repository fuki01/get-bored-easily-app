require 'rails_helper'

RSpec.describe "Points", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/point/show"
      expect(response).to have_http_status(:success)
    end
  end

end
