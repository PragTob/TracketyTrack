require 'spec_helper'

describe "sprints/current_sprint_overview" do

  before (:each) do
    @user_story = FactoryGirl.create(:user_story)
    @other_user_story = FactoryGirl.create(:user_story, name: "Other Name")
    assign(:user_stories_current_sprint, [@user_story])
    assign(:user_stories_in_progress, [@other_user_story])
    assign(:current_user_stories, [@other_user_story])
    view.stub!(signed_in?: true)
    @user = FactoryGirl.create(:user)
    view.stub!(current_user: @user)
    @other_user_story.users << @user
    @other_user_story.save
    assign(:partners, User.accepted_users)
    @project = FactoryGirl.create(:project)
    view.stub!(current_project: @project)
    render
  end

  describe "when there is no current sprint" do

    it "shows a start sprint button" do
      rendered.should have_button("Start Sprint")
    end

    it "shows a notification that there is no current sprint" do
      rendered.should match /There is no current sprint. .*Please start a new one!.*/
    end

  end

  describe "there is a current sprint" do

    before :each do
      @current_sprint = FactoryGirl.create(:sprint)
      @project.current_sprint = @current_sprint
      @project.save
      render
    end

    it "contains one box for the current sprint" do
      rendered.should match /current sprint/i
      rendered.should have_selector("#box_current_sprint")
    end

    describe "there is a user story the current user is working on" do

      it "displays the current user story details box" do
        rendered.should have_selector("#userstory_info_box")
      end

    end

  end

end

