require 'spec_helper'

describe "sprints/show.html.erb" do
  before(:each) do
    @user_story = Factory(:user_story)
    @sprint = assign(:sprint, stub_model(Sprint,
      :number => 1,
      :velocity => 1,
      :start_date => DateTime.now,
      :actual_velocity => 0,
      :user_stories => [@user_story]
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/1/)
    rendered.should match(/1/)
  end

  it "shows a list of the user stories of the sprint" do
    render
    rendered.should match(@user_story.name)
  end

  it "shows a warning if there are no user stories" do
    @sprint.stub(user_stories: [])
    render
    rendered.should match(/no user stories/)
  end

end

