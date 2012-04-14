require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:user, @user)
    view.stub!(current_user: @user)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@user.name)
    rendered.should match(@user.email)
    rendered.should match(@user.description)
  end

  it "has an edit link" do
    render
    rendered.should match /edit/i
  end

  it "has no edit link when the user is not the current user" do
    view.stub! current_user: FactoryGirl.build(:other_user)
    render
    rendered.should_not match /edit/i
  end

end

