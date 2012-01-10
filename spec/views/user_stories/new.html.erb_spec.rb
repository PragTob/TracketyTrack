require 'spec_helper'

describe "user_stories/new" do

  before(:each) do
    @user_story = Factory(:user_story)
    @users = [Factory(:user)]
  end

  let(:page) { Capybara::Node::Simple.new(rendered) }

  it "renders new user_story form" do
    render

    assert_select "form", :action => user_stories_path, :method => "post" do
      assert_select "input#user_story_name", name: "user_story[name]"
      assert_select "textarea#user_story_description", name: "user_story[description]"
      assert_select "textarea#user_story_acceptance_criteria", name: "user_story[acceptance_criteria]"
      assert_select "input#user_story_priority", name: "user_story[priority]"
      assert_select "input#user_story_estimation", name: "user_story[estimation]"
      assert_select "select#user_story_users", name: "user_story[users]"
    end
  end

  it "displays a checkbox" do
    render
    page.has_unchecked_field?("user_story_requesting_feedback")
  end

end

