require 'spec_helper'

describe PageController do

  before (:each) do
    @project = Factory(:project)
  end

  describe "GET 'sprint_planning'" do

    before(:each) do
       @user_story = Factory(:user_story, status: "inactive")
       @other_user_story = Factory(:user_story, status: "inactive")
       sign_in_a_saved_user
    end

    describe "with current sprint" do

      before(:each) do
        @sprint = Factory(:sprint)
        @project.update_attributes(current_sprint: @sprint)
        @project.save
        @user_story.update_attributes(sprint: @sprint)
        @user_story.save
      end

      it "selects all inactive user stories of the current sprint" do
        get :sprint_planning
        assigns(:user_stories_current_sprint).should eq [@user_story]
      end

      it "selects all user stories of the backlog" do
        get :sprint_planning
        assigns(:user_stories_in_backlog).should eq [@other_user_story]
      end

    end

    describe "without current sprint" do

      it "selects empty collection for current sprint" do
        get :sprint_planning
        assigns(:user_stories_current_sprint).should eq []
      end

      it "selects all user stories of the product laptop" do
        get :sprint_planning
        assigns(:user_stories_in_backlog).should eq [@user_story,
                                                     @other_user_story]
      end

    end

    describe "when project exists and user is signed in" do
      it "returns success and renders sprint_planning" do
        get 'sprint_planning'
        response.should be_success
        response.should render_template("sprint_planning")
      end
    end

  end

  describe "GET 'current_sprint'" do

    describe "with current sprint" do

      before(:each) do
        @user_story = Factory(:user_story, status: "inactive")
        @other_user_story = Factory(:user_story, status: "active")
        @sprint = Factory(:sprint)
        @project.update_attributes(current_sprint: @sprint)
        @user_story.update_attributes(sprint: @sprint)
        @other_user_story.update_attributes(sprint: @sprint)
        sign_in_a_saved_user
      end

      it "selects all inactive user stories of the current sprint" do
        get :current_sprint_overview
        assigns(:user_stories_current_sprint).should eq [@user_story]
      end

      it "selects all active user stories of the current sprint" do
        get :current_sprint_overview
        assigns(:user_stories_in_progress).should eq [@other_user_story]
      end

    end

    describe "without current sprint" do

      it "selects empty collections" do
        sign_in_a_saved_user
        get :current_sprint_overview
        assigns(:user_stories_current_sprint).should eq []
        assigns(:user_stories_in_progress).should eq []
      end

    end

    describe "when project exists and user is logged in" do

      it "is successful and renders current_sprint" do
        sign_in_a_saved_user
        get :current_sprint_overview
        response.should be_success
        response.should render_template("current_sprint")
      end

    end

    describe "when no project exists" do

      it "redirects to the new project page" do
        @project.destroy
        get :current_sprint_overview
        response.should redirect_to new_project_path
      end

    end

    describe "when no user was created" do

      it "redirects to the new user page" do
        get :current_sprint_overview
        response.should redirect_to new_user_path
      end

    end

    describe "when user is not signed in" do

      it "redirects to the sign_in page" do
        Factory :user
        controller.should_not be_signed_in
        get :current_sprint_overview
        response.should redirect_to signin_path
      end

    end

  end

end

