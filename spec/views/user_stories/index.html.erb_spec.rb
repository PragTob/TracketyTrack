require 'spec_helper'
require 'capybara'

describe "user_stories/index.html.erb" do
  before(:each) do
    @user_story = Factory(:user_story, status: "inactive")
    @another_user_story = Factory(:user_story, status: "active")
    assign(:user_stories, [@user_story])
  end

  it "renders a list of user_stories" do
    render
    assert_select "tr>td", :text => @user_story.name.to_s, :count => 1
    assert_select "tr>td", :text => @user_story.description.to_s, :count => 1
    assert_select "tr>td", :text => @user_story.acceptance_criteria.to_s, :count => 1
    assert_select "tr>td", :text => @user_story.priority.to_s, :count => 1
    assert_select "tr>td", :text => @user_story.estimation.to_s, :count => 1
  end

  it "shows a 'Start' button if a user story is inactive" do
    render
    rendered.should have_button("Start")
  end

  it "shows a 'Re-Start' button if a user story is inactive" do
    @user_story.update_attributes(status: "completed")
    assign(:user_story, @user_story)
    render
    rendered.should have_button("Re-Start")
  end

  it "shows neither a 'Start' nor a 'Re-Start' button if a user story is active" do
    @user_story.update_attributes(status: "active")
    assign(:user_story, @user_story)
    render
    rendered.should_not have_button("Start")
    rendered.should_not have_button("Re-Start")
  end

  it "shows a 'Complete' button if a user story is active" do
    @user_story.update_attributes(status: "active")
    assign(:user_story, @user_story)
    render
    rendered.should have_button("Complete")
  end

  it "shows only one 'Start' button per inactive/completed user story" do
    assign(:user_stories, [@user_story, @another_user_story])
    render
    assert_select "input", :type => "submit", :value => "Start", :count => 1
  end

  it "shows only one 'Complete' button per active user story" do
    assign(:user_stories, [@user_story, @another_user_story])
    render
    assert_select "input", :type => "submit", :value => "Complete", :count => 1
  end

end

