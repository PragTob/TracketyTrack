require 'spec_helper'

describe "user_stories/new.html.erb" do
  before(:each) do
    @user_story = Factory(:user_story)
  end

  it "renders new user_story form" do
    render

    assert_select "form", :action => user_stories_path, :method => "post" do
      assert_select "input#user_story_name", :name => "user_story[name]"
      assert_select "textarea#user_story_description", :name => "user_story[description]"
      assert_select "textarea#user_story_acceptance_criteria", :name => "user_story[acceptance_criteria]"
      assert_select "input#user_story_priority", :name => "user_story[priority]"
      assert_select "input#user_story_estimation", :name => "user_story[estimation]"
    end
  end
end

