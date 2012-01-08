require 'spec_helper'

describe "users/index.html.erb" do
  before(:each) do
    @user = Factory(:user)
    assign(:users, [@user])
    project = Factory.build(:project)
    view.stub!(current_project: project)
  end

  it "renders a list of users" do
    assign(:unaccepted_users, [])
    render
    assert_select "tr>td", :text => @user.name.to_s, :count => 1
    assert_select "tr>td", :text => @user.email.to_s, :count => 1
    assert_select "tr>td", :text => @user.description.to_s, :count => 1
  end

  it "shows unaccepted users as unaccepted and in the list of all users" do
    assign(:unaccepted_users, [@user])
    render
    assert_select "tr>td", :text => @user.name.to_s, :count => 2
    assert_select "tr>td", :text => @user.email.to_s, :count => 2
    assert_select "tr>td", :text => @user.description.to_s, :count => 2
  end

end

