require 'rails_helper'

RSpec.describe "blogs/new", :type => :view do
  before(:each) do
    assign(:blog, Blog.new(
      :name => "MyString",
      :description => "MyText",
      :User_id => 1
    ))
  end

  it "renders new blog form" do
    render

    assert_select "form[action=?][method=?]", blogs_path, "post" do

      assert_select "input#blog_name[name=?]", "blog[name]"

      assert_select "textarea#blog_description[name=?]", "blog[description]"

      assert_select "input#blog_User_id[name=?]", "blog[User_id]"
    end
  end
end
