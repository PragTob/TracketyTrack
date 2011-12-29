require 'spec_helper'

describe UsersController do

  before :each do
    @user = Factory(:user)
  end

  def valid_attributes
    Factory.attributes_for(:other_user)
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      it "creates a new User" do
        expect {
          post :create, :user => valid_attributes
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, :user => valid_attributes
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, :user => valid_attributes
        response.should redirect_to(signin_path)
      end

      it "creates the first user authorized" do
        post :create, user: Factory.attributes_for(:unaccepted_user)
        User.first.should be_accepted
      end

      it "creates all non first users as not authorized" do
        Factory :other_user
        post :create, user: Factory.attributes_for(:unaccepted_user)
        assigns(:user).should_not be_accepted
      end

    end

    describe "with invalid params" do

      it "assigns a newly created but unsaved user as @user" do
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}
        response.should render_template("new")
      end

    end

  end

  describe "Actions that need a logged in user" do

    before :each do
      test_sign_in @user
    end

    describe "GET show" do
      it "assigns the requested user as @user" do
        get :show, :id => @user.id
        assigns(:user).should eq(@user)
      end
    end

    describe "GET index" do
      it "assigns all users as @users" do
        get :index
        assigns(:users).should eq([@user])
      end
    end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        get :edit, id: @user.id
        assigns(:user).should eq(@user)
      end

      describe "if the user tries to edit another user" do

        before :each do
          @other_user = Factory :other_user
          get :edit, id: @other_user.id
        end

        it "is redirected to the show page" do
          response.should redirect_to @other_user
        end

        it "displays an error flash when it is not the right user" do
          flash[:error].should match /permission/i
        end

      end

    end

    describe "PUT update" do
      describe "with valid params" do

        it "updates the requested user" do
          attributes = valid_attributes.merge(name: "Hugo")
          put :update, :id => @user.id, :user => attributes
          User.find(@user.id).name.should == "Hugo"
        end

        it "assigns the requested user as @user" do
          put :update, :id => @user.id, :user => valid_attributes
          assigns(:user).should eq(@user)
        end

        it "redirects to the user" do
          put :update, :id => @user.id, :user => valid_attributes
          response.should redirect_to(@user)
        end

      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          User.any_instance.stub(:save).and_return(false)
          put :update, :id => @user.id, :user => {}
          assigns(:user).should eq(@user)
        end

        it "re-renders the 'edit' template" do
          User.any_instance.stub(:save).and_return(false)
          put :update, :id => @user.id, :user => {}
          response.should render_template("edit")
        end
      end

      describe "when the edit is for the not currently logged in user" do
        before :each do
          @other_user = Factory :other_user
          attributes = valid_attributes.merge(name: "never change!!!")
          put :update, id: @other_user.id, user: attributes
        end

        it "is redirected to the show page" do
          response.should redirect_to @other_user
        end

        it "displays an error flash when it is not the right user" do
          flash[:error].should match /permission/i
        end

        it "does not change the attributes of the user" do
          User.find(@other_user.id).name.should eq @other_user.name
        end
      end

    end

    describe "DELETE destroy" do

      it "destroys the requested user" do
        expect {
          delete :destroy, :id => @user.id
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        delete :destroy, :id => @user.id
        response.should redirect_to(users_url)
      end

    end

    describe "accept" do

    before :each do
        @unaccepted_user = Factory(:unaccepted_user)
      end

      describe "POST accept_user" do



        it "accepts the user with the given id" do
          post :accept_user, id: @unaccepted_user.id
          User.find(@unaccepted_user.id).should be_accepted
        end

        it "redirects to the accept url" do
          post :accept_user, id: @unaccepted_user.id
          response.should redirect_to(accept_url)
        end

        it "displays a flash message indicating the succesful authorization" do
          post :accept_user, id: @unaccepted_user.id
          flash[:success].should =~ /accepted/i
        end

      end

      describe "GET accept" do
        it "assigns the unaccepted user to @user" do
          get :accept
          assigns(:users).should == [@unaccepted_user]
        end
      end

    end

  end

  describe "No access to these actions without a logged in user" do

    it "has no access to edit" do
      get :edit, id: 1
      response.should redirect_to signin_path
    end

    it "has no access to update" do
      put :update, id: 1
      response.should redirect_to signin_path
    end

    it "has no access to destroy" do
      delete :destroy, id: 1
      response.should redirect_to signin_path
    end

    it "has no access to show" do
      get :show, id: 1
      response.should redirect_to signin_path
    end

    it "has no access to index" do
      get :index
      response.should redirect_to signin_path
    end

  end

end

