require 'spec_helper'

# TODO: demonstrate better tests tomorrow
describe User do

  before :all do
    @attr = Factory.attributes_for(:user)
  end

  before(:each) do
    @user = Factory.build(:user)
  end

  subject{@user}

  it{should respond_to :name}
  it{should respond_to :email}
  it{should respond_to :description}
  it{should respond_to :user_stories}
  it{should respond_to :accepted?}

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

  describe "with a saved user" do

    before :each do
      @user.save
      @found_user = User.find(@user.id)
    end

    it "can be retrieved from the database and is still valid" do
      @found_user.should be_valid
    end

    it "does not change the encrypted password when changing and saving" do
      @found_user.name = "Eggbert"
      @found_user.save
      @found_user.has_password?(@user.password).should be true
    end

  end

  describe "authorize" do

    it "is not accepted when freshly created" do
      user = User.create(name: "Bla",
                         password: "12345678",
                         password_confirmation: "12345678")
      user.should_not be_accepted
    end

    it "can be accepted by calling accept" do
      @unaccepted_user = Factory :unaccepted_user
      @unaccepted_user.accept
      @unaccepted_user.should be_accepted
    end

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

  describe "user stories" do

    before :each do
      @user_story = Factory.build(:user_story)
      @user.user_stories << @user_story
    end

    it "can have an assigned user story" do
      @user.should be_valid
    end

    it "counts the assigned user stories" do
      @user.user_stories.size.should be 1
    end

    it "may not have the same user story assigned twice" do
      @user.user_stories << @user_story
      @user.user_stories.size.should be 1
    end

  end

  describe "Password validation" do

    it "is invalid without a password" do
      Factory.build(:user, password: "").password_valid?.should be false
    end

    it "is invalid without a password confirmation" do
      Factory.build(:user, password_confirmation: "").password_valid?.should be false
    end

    it "is invalid if password and validation don't match" do
      Factory.build(:user,
                    password: "12345678",
                    password_confirmation: "12345679").password_valid?.should be false
    end

    it "is invalid if the password is shorter then 8 characters" do
      shortie = "a" * 7
      Factory.build(:user,
                    password: shortie,
                    password_confirmation: shortie).password_valid?.should be false
    end

    it "rejects long passwords" do
      longie = "a" * 41
      Factory.build(:user,
                    password: longie,
                    password_confirmation: longie).password_valid?.should be false
    end

    describe "an already saved user" do

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

      describe "authenticate method" do

        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
        end

        it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
        end

        it "should return the user on email/password match" do
          matching_user = User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @saved_user
        end

      end

    end

  end

end
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  description        :text
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

