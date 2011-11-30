require 'spec_helper'

describe SessionsController do

  render_views

  describe "POST 'create'" do

    describe "invalid signin" do

      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end

      it "should redirect to the users page" do
        post :create, :session => @attr
        response.should redirect_to users_path
      end

      it "should have a flash message" do
        post :create, :session => @attr
        flash[:error].should =~ /invalid/i
      end

    end

    describe "with valid email and password" do

      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the root path" do
        post :create, :session => @attr
        response.should redirect_to root_path
      end

    end

  end

end

