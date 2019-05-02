require "rails_helper"

RSpec.describe LeadTimesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/lead_times").to route_to("lead_times#index")
    end

    it "routes to #new" do
      expect(:get => "/lead_times/new").to route_to("lead_times#new")
    end

    it "routes to #show" do
      expect(:get => "/lead_times/1").to route_to("lead_times#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/lead_times/1/edit").to route_to("lead_times#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/lead_times").to route_to("lead_times#create")
    end

    it "routes to #update" do
      expect(:put => "/lead_times/1").to route_to("lead_times#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/lead_times/1").to route_to("lead_times#destroy", :id => "1")
    end

  end
end
