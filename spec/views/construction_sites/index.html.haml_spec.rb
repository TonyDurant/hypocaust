require 'rails_helper'

RSpec.describe "construction_sites/index", :type => :view do
  before(:each) do
    assign(:construction_sites, [
      ConstructionSite.create!(
        :name => "Name",
        :nic_name => "Nic Name",
        :address => "Address",
        :customer_name => "Customer Name",
        :email => "Email",
        :phone => "Phone",
        :type => "Type",
        :area => 1.5,
        :avatar => "Avatar",
        :customer_id => 1,
        :manager_id => 2,
        :description => "MyText"
      ),
      ConstructionSite.create!(
        :name => "Name",
        :nic_name => "Nic Name",
        :address => "Address",
        :customer_name => "Customer Name",
        :email => "Email",
        :phone => "Phone",
        :type => "Type",
        :area => 1.5,
        :avatar => "Avatar",
        :customer_id => 1,
        :manager_id => 2,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of construction_sites" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Nic Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Customer Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
