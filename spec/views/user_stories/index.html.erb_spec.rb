require 'spec_helper'
require 'capybara'

describe "user_stories/index.html.erb" do

    before(:each) do
      @user_story = Factory(:user_story, status: "inactive")
      @another_user_story = Factory(:user_story, status: "active")
      @project = Factory(:project)
      view.stub!(current_project: @project)
    end

    it "renders a list of user_stories" do
      assign(:user_stories, [@user_story])
      render
      assert_select "tr>td", :text => @user_story.name.to_s, :count => 1
      assert_select "tr>td", :text => @user_story.priority.to_s, :count => 1
      assert_select "tr>td", :text => @user_story.estimation.to_s, :count => 1
    end

    it "shows the current status of the user story" do
      assign(:user_stories, [@user_story, @another_user_story])
      render
      assert_select "tr>td", text: @user_story.status, count: 1
      assert_select "tr>td", text: @another_user_story.status, count: 1
    end

end

