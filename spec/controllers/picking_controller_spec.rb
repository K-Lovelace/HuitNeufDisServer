require 'rails_helper'

RSpec.describe PickingController, type: :controller do

  describe "GET #notifications" do
    it "returns http success" do
      get :notifications
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #supervisor" do
    it "returns http success" do
      get :supervisor
      expect(response).to have_http_status(:success)
    end
  end

end
