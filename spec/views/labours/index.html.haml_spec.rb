require 'rails_helper'

RSpec.describe "labours/index", :type => :view do
  before(:each) do
    assign(:labours, [
      Labour.create!(),
      Labour.create!()
    ])
  end

  it "renders a list of labours" do
    render
  end
end
