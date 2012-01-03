require 'spec_helper'

describe "comments/new.html.erb" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :user_story_id => 1,
      :user_id => 1,
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comments_path, :method => "post" do
      assert_select "input#comment_user_story_id", :name => "comment[user_story_id]"
      assert_select "input#comment_user_id", :name => "comment[user_id]"
      assert_select "textarea#comment_content", :name => "comment[content]"
    end
  end
end
