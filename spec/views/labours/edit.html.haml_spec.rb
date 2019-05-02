require 'rails_helper'

RSpec.describe "labours/edit", :type => :view do
  before(:each) do
    @labour = assign(:labour, Labour.create!())
  end

  it "renders the edit labour form" do
    render

    assert_select "form[action=?][method=?]", labour_path(@labour), "post" do
    end
  end
end
