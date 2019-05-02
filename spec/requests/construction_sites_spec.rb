require 'rails_helper'

RSpec.describe "ConstructionSites", :type => :request do
  describe "GET /construction_sites" do
    it "works! (now write some real specs)" do
      get construction_sites_path
      expect(response).to have_http_status(200)
    end
  end
end
