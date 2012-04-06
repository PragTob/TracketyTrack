require 'spec_helper'

describe SessionsHelper do

  describe "is_current_user?" do

    before :each do
      @user = FactoryGirl.build :user
      view.current_user = @user
    end

    it "returns true if the given user is the current user" do
      view.current_user?(@user).should be true
    end

    it "returns false if the given user is not the current user" do
      other_user = FactoryGirl.build :other_user
      view.current_user?(other_user).should be false
    end

  end

end

