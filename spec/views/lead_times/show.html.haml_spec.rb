require 'rails_helper'

RSpec.describe "lead_times/show", :type => :view do
  before(:each) do
    @lead_time = assign(:lead_time, LeadTime.create!(
      :title => "Title",
      :user_id => "User",
      :construction_site_id => "Construction Site"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/User/)
    expect(rendered).to match(/Construction Site/)
  end
end
