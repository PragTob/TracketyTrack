require 'spec_helper'

describe PageController do

  def valid_project_attributes
    Factory.attributes_for(:project)
  end

  def valid_user_attributes
    Factory.attributes_for(:user)
  end

  describe "GET 'sprint_planning'" do
    it "returns success and renders sprint_planning if (project exists, user is signed in)" do
      Project.create! valid_project_attributes
      test_sign_in(Factory(:user))
      get 'sprint_planning'
      response.should be_success
      response.should render_template("sprint_planning")
    end

  end

  describe "GET 'current_sprint'" do
    it "returns http success and renders current_sprint when a project exists and a user is signed in" do
      Project.create! valid_project_attributes
      test_sign_in(Factory(:user))
      get 'current_sprint'
      response.should be_success
      response.should render_template("current_sprint")
    end

    it "redirects to the new project page if no project was created" do
      get :current_sprint
      response.should redirect_to new_project_path
    end

    it "redirects to the new user page if a project was created and no user was created yet" do
      Project.create! valid_project_attributes
      get :current_sprint
      response.should redirect_to new_user_path
    end

    it "redirects to the sign_in page if no user is signed in and a project exists" do
      Project.create! valid_project_attributes
      User.create! valid_user_attributes
      controller.should_not be_signed_in
      get 'current_sprint'
      response.should redirect_to signin_path
    end

  end

end

