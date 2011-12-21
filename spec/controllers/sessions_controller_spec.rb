require 'spec_helper'

describe SessionsController do

  render_views

  describe "POST 'create'" do

    describe "invalid signin" do

      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end

      it "should redirect to the signin page" do
        post :create, :session => @attr
        response.should redirect_to signin_path
      end

      it "should have a flash message" do
        post :create, :session => @attr
        flash[:error].should =~ /invalid/i
      end

    end

    describe "with valid email and password" do
      describe "and accepted" do

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

      describe "and not accepted" do

        before(:each) do
          @user = Factory(:unaccepted_user)
          @attr = { :email => @user.email, :password => @user.password }
        end

        it "should not sign the user in" do
          post :create, :session => @attr
          controller.should_not be_signed_in
        end

        it "should have a flash message" do
          post :create, :session => @attr
          flash[:error].should =~ /accepted/i
        end

      end
    end

    describe "DELETE 'destroy'" do

      it "should sign a user out" do
        test_sign_in(Factory(:user))
        delete :destroy
        controller.should_not be_signed_in
        controller.current_user.should be_nil
        response.should redirect_to(root_path)
      end

    end

  end

end

