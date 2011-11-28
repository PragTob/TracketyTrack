require 'spec_helper'

describe "users/edit.html.erb" do
  before(:each) do
    @user = Factory(:user)
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "textarea#user_description", :name => "user[description]"
    end
  end
end
