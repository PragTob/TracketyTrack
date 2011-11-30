require 'spec_helper'

describe "users/new.html.erb" do
  before(:each) do
    @user = Factory(:user)
  end

  it "renders new user form" do
    render

    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_name", name: "user[name]"
      assert_select "input#user_email", name: "user[email]"
      assert_select "textarea#user_description", name: "user[description]"
      assert_select "input#user_password", name: "user[password]"
      assert_select "input#user_password_confirmation", name: "user[password_confirmation"
    end
  end
end

