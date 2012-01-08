require 'spec_helper'

describe "users/index" do
  before(:each) do
    @user = Factory(:user)
    assign(:users, [@user])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => @user.name.to_s, :count => 1
    assert_select "tr>td", :text => @user.email.to_s, :count => 1
    assert_select "tr>td", :text => @user.description.to_s, :count => 1
  end
end

