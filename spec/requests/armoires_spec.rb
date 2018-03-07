require 'rails_helper'

RSpec.describe "Armoires", type: :request do
  describe "GET /armoires" do
    it "works! (now write some real specs)" do
      get armoires_path
      expect(response).to have_http_status(200)
    end
  end
end
