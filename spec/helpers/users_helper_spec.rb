require 'spec_helper'

describe UsersHelper do

  describe "set_accepted" do
    before :each do
      @unaccepted = FactoryGirl.build :unaccepted_user
    end

    it "sets accepted to true when the user is the first user" do
      set_accepted @unaccepted
      @unaccepted.should be_accepted
    end

    it "sets accepted to false when the user is not the first user" do
      FactoryGirl.create :user
      set_accepted @unaccepted
      @unaccepted.should_not be_accepted
    end
  end

  describe "form_action_for_user" do

    it "returns label for register button if user is not saved yet" do
      user = FactoryGirl.build(:user)
      form_action_for_user(user).should eq "Register now"
    end

    it "returns label for edit button if user is already saved" do
      user = FactoryGirl.create(:user)
      form_action_for_user(user).should eq "Edit my profile"
    end

  end

end

