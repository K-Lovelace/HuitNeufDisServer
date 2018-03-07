require "rails_helper"

RSpec.describe ArmoiresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/armoires").to route_to("armoires#index")
    end


    it "routes to #show" do
      expect(:get => "/armoires/1").to route_to("armoires#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/armoires").to route_to("armoires#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/armoires/1").to route_to("armoires#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/armoires/1").to route_to("armoires#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/armoires/1").to route_to("armoires#destroy", :id => "1")
    end

  end
end
