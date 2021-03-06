require 'spec_helper'

describe "user_stories/edit" do

  let(:page) { Capybara::Node::Simple.new(rendered) }

  before(:each) do
    @user_story = FactoryGirl.create(:user_story)
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:other_user)
    @users = [@user, @other_user]
  end

  it "renders the edit user_story form" do
    render

    assert_select "form", :action => user_stories_path(@user_story), :method => "post" do
      assert_select "input#user_story_name", name: "user_story[name]"
      assert_select "textarea#user_story_description", name: "user_story[description]"
      assert_select "textarea#user_story_acceptance_criteria", name: "user_story[acceptance_criteria]"
      assert_select "input#user_story_priority", name: "user_story[priority]"
      assert_select "input#user_story_estimation", name: "user_story[estimation]"
      assert_select "select#user_story_users", name: "user_story[users]"
    end
  end

  it "preselects the currently assigned user" do
    @user_story.users << @user
    @user_story.save
    render

    page.has_select?("user_story_users", selected: @user.name).should be true
  end

  it "preselects two currently assigned users" do
     @user_story.users =  @users
     @user_story.save
     render

     page.has_select?("user_story_users", selected: @users.map(&:name)).should be true
   end

   it "displays the users" do
     render
     page.has_select?("user_story_users", options: @users.map(&:name)).should be true
   end

   it "displays a checkbox" do
     render
     page.has_unchecked_field?("user_story_requesting_feedback")
   end

end

