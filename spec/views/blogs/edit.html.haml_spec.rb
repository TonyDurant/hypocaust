require 'rails_helper'

RSpec.describe "blogs/edit", :type => :view do
  before(:each) do
    @blog = assign(:blog, Blog.create!(
      :name => "MyString",
      :description => "MyText",
      :User_id => 1
    ))
  end

  it "renders the edit blog form" do
    render

    assert_select "form[action=?][method=?]", blog_path(@blog), "post" do

      assert_select "input#blog_name[name=?]", "blog[name]"

      assert_select "textarea#blog_description[name=?]", "blog[description]"

      assert_select "input#blog_User_id[name=?]", "blog[User_id]"
    end
  end
end
