require 'rails_helper'

RSpec.describe "labours/show", :type => :view do
  before(:each) do
    @labour = assign(:labour, Labour.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
