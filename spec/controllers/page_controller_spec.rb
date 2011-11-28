require 'spec_helper'

describe PageController do

  def valid_project_attributes
    Factory.attributes_for(:project)
  end

  def valid_user_attributes
    Factory.attributes_for(:user)
  end

  describe "GET 'index'" do
    it "returns http success when already at least one user and one project exist" do
      Project.create! valid_project_attributes
      User.create! valid_user_attributes
      get 'index'
      response.should be_success
    end

    it "redirects to the new project page if no project was created" do
      get :index
      response.should redirect_to new_project_path
    end

    it "redirects to the new user page if a project was created and no user was created yet" do
      Project.create! valid_project_attributes
      get :index
      response.should redirect_to new_user_path
    end

  end

end

