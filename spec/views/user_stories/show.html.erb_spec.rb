require 'spec_helper'

describe "user_stories/show.html.erb" do
  before(:each) do
    @user_story = Factory(:user_story, status: "inactive")
    assign(:user_story, @user_story)
  end

  after(:each) do
    @user_story.destroy
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@user_story.name)
    rendered.should match(@user_story.description)
    rendered.should match(@user_story.acceptance_criteria)
    rendered.should match(@user_story.priority.to_s)
    rendered.should match(@user_story.estimation.to_s)
  end

  it "shows a 'Start' button if the user story is inactive" do
    render
    rendered.should have_button("Start")
  end

  it "shows a 'Re-Start' button if the user story is inactive" do
    @user_story.update_attributes(status: "completed")
    assign(:user_story, @user_story)
    render
    rendered.should have_button("Re-Start")
  end

  it "shows neither a 'Start' nor a 'Re-Start' button if the user story is active" do
    @user_story.update_attributes(status: "active")
    assign(:user_story, @user_story)
    render
    rendered.should_not have_button("Start")
    rendered.should_not have_button("Re-Start")
  end

  it "shows a 'Complete' button if the user story is active" do
    @user_story.update_attributes(status: "active")
    assign(:user_story, @user_story)
    render
    rendered.should have_button("Complete")
  end

end

