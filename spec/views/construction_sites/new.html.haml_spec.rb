require 'rails_helper'

RSpec.describe "construction_sites/new", :type => :view do
  before(:each) do
    assign(:construction_site, ConstructionSite.new(
      :name => "MyString",
      :nic_name => "MyString",
      :address => "MyString",
      :customer_name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :type => "",
      :area => 1.5,
      :avatar => "MyString",
      :customer_id => 1,
      :manager_id => 1,
      :description => "MyText"
    ))
  end

  it "renders new construction_site form" do
    render

    assert_select "form[action=?][method=?]", construction_sites_path, "post" do

      assert_select "input#construction_site_name[name=?]", "construction_site[name]"

      assert_select "input#construction_site_nic_name[name=?]", "construction_site[nic_name]"

      assert_select "input#construction_site_address[name=?]", "construction_site[address]"

      assert_select "input#construction_site_customer_name[name=?]", "construction_site[customer_name]"

      assert_select "input#construction_site_email[name=?]", "construction_site[email]"

      assert_select "input#construction_site_phone[name=?]", "construction_site[phone]"

      assert_select "input#construction_site_type[name=?]", "construction_site[type]"

      assert_select "input#construction_site_area[name=?]", "construction_site[area]"

      assert_select "input#construction_site_avatar[name=?]", "construction_site[avatar]"

      assert_select "input#construction_site_customer_id[name=?]", "construction_site[customer_id]"

      assert_select "input#construction_site_manager_id[name=?]", "construction_site[manager_id]"

      assert_select "textarea#construction_site_description[name=?]", "construction_site[description]"
    end
  end
end
