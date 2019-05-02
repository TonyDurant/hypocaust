require 'rails_helper'

RSpec.describe "Labours", :type => :request do
  describe "GET /labours" do
    it "works! (now write some real specs)" do
      get labours_path
      expect(response).to have_http_status(200)
    end
  end
end
