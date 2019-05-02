require 'rails_helper'

RSpec.describe "comments/new", :type => :view do
  before(:each) do
    assign(:comment, Comment.new(
      :body => "MyString",
      :user_id => 1,
      :file => "MyString",
      :status => "MyString"
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input#comment_body[name=?]", "comment[body]"

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"

      assert_select "input#comment_file[name=?]", "comment[file]"

      assert_select "input#comment_status[name=?]", "comment[status]"
    end
  end
end
