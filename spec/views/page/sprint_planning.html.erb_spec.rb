require 'spec_helper'

describe "page/sprint_planning.html.erb" do

  before (:each) do
    view.stub!(current_project: Factory.build(:project))
    @user_story = Factory.build(:user_story)
    @other_user_story = Factory.build(:user_story, name: "Other Name")
    assign(:user_stories_current_sprint, [@user_story])
    assign(:user_stories_in_backlog, [@other_user_story])
    view.stub!(signed_in?: true)
    @user = Factory(:user)
    view.stub!(current_user: @user)
    render
  end
  it "contains one box for the current sprint" do
    rendered.should have_content("CURRENT SPRINT")
    rendered.should have_selector("#box_current_sprint")
  end

  it "contains one box for the backlog" do
    rendered.should have_content("BACKLOG")
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
end

