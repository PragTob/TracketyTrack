require 'spec_helper'

describe UserStoriesHelper do

  describe "set_sprint" do
    it "sets the sprint to the given value" do
      @user_story = Factory(:user_story)
      @sprint = Factory.build(:sprint)
      set_sprint(@user_story.id, @sprint)
      UserStory.find(@user_story.id).sprint.should eq @sprint
    end
  end

  describe "add_users" do

    before :each do
      @user = Factory :user
      @params = { user_story: {} }
    end

    it "adds the users to the hash if the ID's are given" do
      @params[:user_story][:users] = [@user.id]
      add_users @params
      @params[:user_story][:users].should eq [@user]
    end

    it "adds an empty array when nothing is given" do
      add_users @params
      @params[:user_story][:users].should eq []
    end

  end

end

