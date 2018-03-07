require "rails_helper"

RSpec.describe PortesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/portes").to route_to("portes#index")
    end


    it "routes to #show" do
      expect(:get => "/portes/1").to route_to("portes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/portes").to route_to("portes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/portes/1").to route_to("portes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/portes/1").to route_to("portes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/portes/1").to route_to("portes#destroy", :id => "1")
    end

  end
end
