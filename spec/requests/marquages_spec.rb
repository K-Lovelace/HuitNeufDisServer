require 'rails_helper'

RSpec.describe "Marquages", type: :request do
  describe "GET /marquages" do
    it "works! (now write some real specs)" do
      get marquages_path
      expect(response).to have_http_status(200)
    end
  end
end
