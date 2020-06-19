require 'rails_helper'

RSpec.describe "Visitors", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/visitors/index"
      expect(response).to have_http_status(:success)
    end
  end

end
