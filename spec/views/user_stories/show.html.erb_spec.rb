require 'spec_helper'

describe "user_stories/show.html.erb" do
  before(:each) do
    @user_story = Factory(:user_story)
    assign(:user_story, @user_story)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@user_story.name)
    rendered.should match(@user_story.description)
    rendered.should match(@user_story.acceptance_criteria)
    rendered.should match(@user_story.priority.to_s)
    rendered.should match(@user_story.estimation.to_s)
  end
end

