require 'spec_helper'

describe UsersHelper do

  describe "set_authorized" do
    before :each do
      @unauthorized = Factory.build :unauthorized_user
    end

    it "sets authorized to true when the user is the first user" do
      set_accepted @unauthorized
      @unauthorized.should be_accepted
    end

    it "sets authorized to false when the user is not the first user" do
      Factory :user
      set_accepted @unauthorized
      @unauthorized.should_not be_accepted
    end
  end

end

