require 'rails_helper'

RSpec.describe "DeviseUsers", type: :request do
  describe "GET /devise_users" do
    it "works! (now write some real specs)" do
      get devise_users_index_path
      expect(response).to have_http_status(200)
    end
  end
end
