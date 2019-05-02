require 'rails_helper'

RSpec.describe "lead_times/index", :type => :view do
  before(:each) do
    assign(:lead_times, [
      LeadTime.create!(
        :title => "Title",
        :user_id => "User",
        :construction_site_id => "Construction Site"
      ),
      LeadTime.create!(
        :title => "Title",
        :user_id => "User",
        :construction_site_id => "Construction Site"
      )
    ])
  end

  it "renders a list of lead_times" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Construction Site".to_s, :count => 2
  end
end
