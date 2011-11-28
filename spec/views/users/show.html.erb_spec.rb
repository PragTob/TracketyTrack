require 'spec_helper'

describe "users/show.html.erb" do
  before(:each) do
    @user = Factory(:user)
    assign(:user, @user)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@user.name)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@user.email)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@user.description)
  end
end
