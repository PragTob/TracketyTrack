require 'spec_helper'

describe User do
  before(:all) do
    @user1 = Factory.build(:user)
    @user2 = Factory.build(:user)
  end

  subject{@user1}

  it{should respond_to :name}
  it{should respond_to :email}
  it{should respond_to :description}

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
end
