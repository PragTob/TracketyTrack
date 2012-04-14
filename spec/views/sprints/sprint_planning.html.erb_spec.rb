require 'spec_helper'

describe "sprints/sprint_planning" do

  before (:each) do
    @user_story = FactoryGirl.create(:user_story)
    @other_user_story = FactoryGirl.create(:user_story, name: "Other Name")
    assign(:user_stories_current_sprint, [@user_story])
    assign(:user_stories_in_backlog, [@other_user_story])
    view.stub!(signed_in?: true)
    @user = FactoryGirl.create(:user)
    view.stub!(current_user: @user)
    @project = FactoryGirl.create(:project)
    view.stub!(current_project: @project)
    render
  end

  it "contains one box for the current sprint" do
    rendered.should match /current sprint/i
    rendered.should have_selector("#box_current_sprint")
  end

  it "contains one box for the backlog" do
    rendered.should match /backlog/i
    rendered.should have_selector("#box_backlog")
  end

  describe "backlog box" do
    it "shows only user stories without assigned sprint" do
      rendered.should have_selector("#box_backlog") do |backlog|
        backlog.inner_html.should have_content(@other_user_story.name)
        backlog.inner_html.should_not have_content(@user_story.name)
      end
    end
  end

  describe "current sprint box" do
    it "shows only user stories that are assigned to the current sprint" do
      rendered.should have_selector("#box_current_sprint") do |current_sprint|
        current_sprint.inner_html.should_not have_content(@other_user_story.name)
        current_sprint.inner_html.should have_content(@user_story.name)
      end
    end
  end

  describe "when there is no current sprint" do

    it "shows a start sprint button" do
      rendered.should have_button("Start Sprint")
    end

    it "shows a notification that there is no current sprint" do
      rendered.should match /There is no current sprint. .*Please start a new one!.*/
    end

  end

  describe "when there is a current sprint" do

    it "shows a 'Stop Sprint' button" do
      @project.current_sprint = FactoryGirl.create(:sprint)
      render
      rendered.should have_button("Stop Sprint")
    end

  end

end

