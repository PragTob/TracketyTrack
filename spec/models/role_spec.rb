require 'spec_helper'

describe Role do
  before :each do
    @role = Factory.build(:role)
    @user = Factory.build(:user)
  end

  it "has no users associated when created" do
    @role.users.should be_empty
  end

  it "can have a user assigned" do
    @role.users << @user
    @role.users.should_not be_empty
  end

  it "can have multiple users assigned" do
    @role.users << @user << Factory.build(:other_user)
    @role.users.size.should == 2
  end

end

# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

