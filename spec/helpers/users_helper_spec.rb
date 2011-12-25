require 'spec_helper'

describe UsersHelper do

  describe "set_accepted" do
    before :each do
      @unaccepted = Factory.build :unaccepted_user
    end

    it "sets accepted to true when the user is the first user" do
      set_accepted @unaccepted
      @unaccepted.should be_accepted
    end

    it "sets accepted to false when the user is not the first user" do
      Factory :user
      set_accepted @unaccepted
      @unaccepted.should_not be_accepted
    end
  end

end

