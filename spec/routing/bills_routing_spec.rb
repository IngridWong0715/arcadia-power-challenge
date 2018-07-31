require "rails_helper"

RSpec.describe BillsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bills").to route_to("bills#index")
    end


    it "routes to #show" do
      expect(:get => "/bills/1").to route_to("bills#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/bills").to route_to("bills#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bills/1").to route_to("bills#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bills/1").to route_to("bills#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bills/1").to route_to("bills#destroy", :id => "1")
    end

  end
end
