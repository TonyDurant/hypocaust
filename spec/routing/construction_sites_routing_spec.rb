require "rails_helper"

RSpec.describe ConstructionSitesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/construction_sites").to route_to("construction_sites#index")
    end

    it "routes to #new" do
      expect(:get => "/construction_sites/new").to route_to("construction_sites#new")
    end

    it "routes to #show" do
      expect(:get => "/construction_sites/1").to route_to("construction_sites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/construction_sites/1/edit").to route_to("construction_sites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/construction_sites").to route_to("construction_sites#create")
    end

    it "routes to #update" do
      expect(:put => "/construction_sites/1").to route_to("construction_sites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/construction_sites/1").to route_to("construction_sites#destroy", :id => "1")
    end

  end
end
