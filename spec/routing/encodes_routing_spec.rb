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

    it "routes to #create" do
      expect(:post => "/encodes").to route_to("encodes#create")
    end

  end
end
