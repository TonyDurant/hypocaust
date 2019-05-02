require "rails_helper"

RSpec.describe LaboursController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/labours").to route_to("labours#index")
    end

    it "routes to #new" do
      expect(:get => "/labours/new").to route_to("labours#new")
    end

    it "routes to #show" do
      expect(:get => "/labours/1").to route_to("labours#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/labours/1/edit").to route_to("labours#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/labours").to route_to("labours#create")
    end

    it "routes to #update" do
      expect(:put => "/labours/1").to route_to("labours#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/labours/1").to route_to("labours#destroy", :id => "1")
    end

  end
end
