require 'rails_helper'

RSpec.describe "lead_times/edit", :type => :view do
  before(:each) do
    @lead_time = assign(:lead_time, LeadTime.create!(
      :title => "MyString",
      :user_id => "MyString",
      :construction_site_id => "MyString"
    ))
  end

  it "renders the edit lead_time form" do
    render

    assert_select "form[action=?][method=?]", lead_time_path(@lead_time), "post" do

      assert_select "input#lead_time_title[name=?]", "lead_time[title]"

      assert_select "input#lead_time_user_id[name=?]", "lead_time[user_id]"

      assert_select "input#lead_time_construction_site_id[name=?]", "lead_time[construction_site_id]"
    end
  end
end
