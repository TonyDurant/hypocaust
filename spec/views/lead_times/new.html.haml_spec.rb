require 'rails_helper'

RSpec.describe "lead_times/new", :type => :view do
  before(:each) do
    assign(:lead_time, LeadTime.new(
      :title => "MyString",
      :user_id => "MyString",
      :construction_site_id => "MyString"
    ))
  end

  it "renders new lead_time form" do
    render

    assert_select "form[action=?][method=?]", lead_times_path, "post" do

      assert_select "input#lead_time_title[name=?]", "lead_time[title]"

      assert_select "input#lead_time_user_id[name=?]", "lead_time[user_id]"

      assert_select "input#lead_time_construction_site_id[name=?]", "lead_time[construction_site_id]"
    end
  end
end
