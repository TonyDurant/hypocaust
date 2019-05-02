require 'rails_helper'

RSpec.describe "labours/new", :type => :view do
  before(:each) do
    assign(:labour, Labour.new())
  end

  it "renders new labour form" do
    render

    assert_select "form[action=?][method=?]", labours_path, "post" do
    end
  end
end
