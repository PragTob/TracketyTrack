require 'spec_helper'

# TODO: demonstrate better tests tomorrow
describe User do

  before(:each) do
    @user = Factory.build(:user)
  end

  subject{@user}

  it{should respond_to :name}
  it{should respond_to :email}
  it{should respond_to :description}

  context "given valid attributes" do
    it { should be_valid }
  end

  context "without a name" do
    before { @user.name = nil }
    it { should_not be_valid }
  end

  context "without an email" do
    before { @user.email = nil }
    it { should_not be_valid }
  end


  context "when email has not the correct format" do
    before{@user.email = "florian"}
    it{should_not be_valid}
  end

  context "when email is already taken by an other user" do
    before{Factory(:user)}
    it{should_not be_valid}
  end

  describe "Role" do
    before :all do
      @role = Factory.build(:role)
    end

    it "should have empty roles upon creation" do
      @user.roles.should be_empty
    end

    it "can have a role assigned" do
      @user.roles << @role
      @user.roles.size.should == 1
      @user.should be_valid
    end

    it "can have multiple roles assigned" do
      @user.roles << @role << Factory.build(:other_role)
      @user.roles.size.should == 2
    end

  end

end
# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  email       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

