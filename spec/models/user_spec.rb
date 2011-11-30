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

  describe "Password validation" do

    it "is invalid without a password" do
      Factory.build(:user, password: "").should_not be_valid
    end

    it "is invalid without a password confirmation" do
      Factory.build(:user, password_confirmation: "").should_not be_valid
    end

    it "is invalid if password and validation don't match" do
      Factory.build(:user,
                    password: "12345678",
                    password_confirmation: "12345679").should_not be_valid
    end

    it "is invalid if the password is shorter then 8 characters" do
      shortie = "a" * 7
      Factory.build(:user,
                    password: shortie,
                    password_confirmation: shortie).should_not be_valid
    end

    it "rejects long passwords" do
      longie = "a" * 41
      Factory.build(:user,
                    password: longie,
                    password_confirmation: longie).should_not be_valid
    end

    describe "with encrypted password" do

      before :each do
        @saved_user = Factory(:user)
      end

      it "should be true if the passwords match" do
        @saved_user.has_password?(Factory.attributes_for(:user)[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @saved_user.has_password?("invalid").should be_false
      end


      it "should have an encrypted password attribute" do
        @saved_user.should respond_to(:encrypted_password)
      end

      it "should set the encrypted password" do
        @saved_user.encrypted_password.should_not be_blank
      end

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

