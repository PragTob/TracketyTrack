require 'spec_helper'

describe "users/index.html.erb" do
  before(:each) do
    @user = Factory(:user)
    assign(:users, [@user])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user.name.to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user.email.to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user.description.to_s, :count => 1
  end
end
