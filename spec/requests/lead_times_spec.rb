require 'rails_helper'

RSpec.describe "LeadTimes", :type => :request do
  describe "GET /lead_times" do
    it "works! (now write some real specs)" do
      get lead_times_path
      expect(response).to have_http_status(200)
    end
  end
end
