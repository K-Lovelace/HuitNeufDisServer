require 'rails_helper'

RSpec.describe "Portes", type: :request do
  describe "GET /portes" do
    it "works! (now write some real specs)" do
      get portes_path
      expect(response).to have_http_status(200)
    end
  end
end
