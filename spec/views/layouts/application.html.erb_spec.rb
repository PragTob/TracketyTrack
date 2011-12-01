require 'spec_helper'

describe "layouts/application.html.erb" do

  describe "logged out" do
    before :each do
      view.stub!(:signed_in?).and_return(false)
    end

    it "contains a link to register a new user" do
      render
      rendered.should have_link("Register", href: new_user_path)
    end

    it "contains a login part" do
      render
      rendered.should have_button("Sign in")
    end

    it "does not contain a logout button" do
      render
      rendered.should_not have_button("Logout")
    end

  end

  describe "logged in" do

    before :each do
      view.stub!(:signed_in?).and_return(true)
    end

    it "contains a logout button" do
      render
      rendered.should have_button("Logout")
    end

    it "does not contain a link to register a new user" do
      render
      rendered.should_not have_link("Register", href: new_user_path)
    end

    it "does contain a login part" do
      render
      rendered.should_not have_button("Sign in")
    end

  end

end

