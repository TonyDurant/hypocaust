require 'rails_helper'

RSpec.describe "construction_sites/show", :type => :view do
  before(:each) do
    @construction_site = assign(:construction_site, ConstructionSite.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Nic Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Customer Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Avatar/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
