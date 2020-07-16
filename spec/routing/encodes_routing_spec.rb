require "rails_helper"

RSpec.describe EncodesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/encodes").to route_to("encodes#index")
    end

    it "routes to #new" do
      expect(:get => "/encodes/new").to route_to("encodes#new")
    end

    it "routes to #show" do
      expect(:get => "/encodes/1").to route_to("encodes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/encodes/1/edit").to route_to("encodes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/encodes").to route_to("encodes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/encodes/1").to route_to("encodes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/encodes/1").to route_to("encodes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/encodes/1").to route_to("encodes#destroy", :id => "1")
    end
  end
end
