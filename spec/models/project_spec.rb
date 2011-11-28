require 'spec_helper'

describe Project do
  before :each do
    @project = Factory.build(:project)
    @user = Factory.build(:user)
    @valid_attributes = {:name => "ProjectName"}
  end

  it "can be created with valid attributes" do
    User.new(@valid_attributes).should be_valid
  end

  it "can have a user assigned" do
    @project.user = @user
    @project.user.should_not be_nil
  end
end

