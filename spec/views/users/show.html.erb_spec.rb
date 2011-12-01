require 'spec_helper'

describe "users/show.html.erb" do
  before(:each) do
    @user = Factory(:user)
    assign(:user, @user)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@user.name)
    rendered.should match(@user.email)
    rendered.should match(@user.description)
  end
end

