require "rails_helper"

RSpec.describe MarquagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/marquages").to route_to("marquages#index")
    end


    it "routes to #show" do
      expect(:get => "/marquages/1").to route_to("marquages#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/marquages").to route_to("marquages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marquages/1").to route_to("marquages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marquages/1").to route_to("marquages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marquages/1").to route_to("marquages#destroy", :id => "1")
    end

  end
end
