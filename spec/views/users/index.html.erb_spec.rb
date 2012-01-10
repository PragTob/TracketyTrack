require 'spec_helper'

describe "users/index" do
  before(:each) do
    @user = Factory(:user)
    assign(:users, [@user])
    @unaccepted_user = Factory(:other_user, accepted: false)
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

  it "shows unaccepted users only in the unaccepted list" do
    assign(:unaccepted_users, [@unaccepted_user])
    render
    assert_select "tr>td", :text => @unaccepted_user.name.to_s, :count => 1
    assert_select "tr>td", :text => @unaccepted_user.email.to_s, :count => 1
    assert_select "tr>td", :text => @unaccepted_user.description.to_s, :count => 1
  end

end

