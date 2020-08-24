require 'rails_helper'

RSpec.describe "UsersAutentications", type: :request do
  describe "GET /users_autentications" do
    it "works! (now write some real specs)" do
      get users_autentications_index_path
      expect(response).to have_http_status(200)
    end
  end
end
