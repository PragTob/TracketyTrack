require 'spec_helper'

describe "user_stories/index" do

    before(:each) do
      @user_story = FactoryGirl.create(:user_story, status: "inactive")
      @another_user_story = FactoryGirl.create(:user_story, status: "active")
      @project = FactoryGirl.create(:project)
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

