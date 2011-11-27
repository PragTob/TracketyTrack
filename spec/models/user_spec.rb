require 'spec_helper'

# TODO: demonstrate better tests tomorrow
describe User do

  before(:each) do
    @user1 = Factory.build(:user)
    @user2 = Factory.build(:user)
  end

  def valid_attributes
    {name: "Peter", email: "peterinchen@example.com"}
  end

  subject{@user1}

  it{should respond_to :name}
  it{should respond_to :email}
  it{should respond_to :description}

  it "can be created with valid attributes" do
    User.new(valid_attributes).should be_valid
  end

  it "is invalid without a name" do
    User.new(valid_attributes.merge(name: nil)).should_not be_valid
  end

  context "when name is not given" do
    before{@user1.name = nil}
    after{@user1.name = @user2.name}
    it{should_not be_valid}
  end

  context "when email is not given" do
    before{@user1.email = nil}
    after{@user1.email = @user2.email}
    it{should_not be_valid}
  end

  context "when email has not the correct format" do
    before{@user1.email = "florian"}
    after{@user1.email = @user2.email}
    it{should_not be_valid}
  end

  context "when email is already taken by an other user" do
    before{@user2.save}
    after{@user2.destroy}
    it{should_not be_valid}
  end

  describe "Role" do
    before :all do
      @role = Factory.build(:role)
    end

    it "should have empty roles upon creation" do
      @user1.roles.should be_empty
    end

    it "can have a role assigned" do
      @user1.roles << @role
      @user1.roles.size.should == 1
      @user1.should be_valid
    end

    it "can have multiple roles assigned" do
      @user1.roles << @role << Factory.build(:other_role)
      @user1.roles.size.should == 2
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

