require 'spec_helper'

describe "user_stories/edit.html.erb" do

  let(:page) { Capybara::Node::Simple.new(rendered) }

  before(:each) do
    @user_story = Factory(:user_story)
    @user = Factory(:user)
    @users = [@user, Factory(:other_user)]
  end

  it "renders the edit user_story form" do
    render

    assert_select "form", :action => user_stories_path(@user_story), :method => "post" do
      assert_select "input#user_story_name", name: "user_story[name]"
      assert_select "textarea#user_story_description", name: "user_story[description]"
      assert_select "textarea#user_story_acceptance_criteria", name: "user_story[acceptance_criteria]"
      assert_select "input#user_story_priority", name: "user_story[priority]"
      assert_select "input#user_story_estimation", name: "user_story[estimation]"
      assert_select "select#user_story_user_id", name: "user_story[user_id]"
    end
  end

  it "preselects the currently assigned user" do
    @user_story.user = @user
    @user_story.save
    render

    page.has_select?("user_story[user_id]", selected: @user.name).should == true
  end

end

