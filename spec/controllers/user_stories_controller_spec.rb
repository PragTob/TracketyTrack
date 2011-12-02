require 'spec_helper'

describe UserStoriesController do

  describe "all actions need a logged in user" do

    before :each do
      @user_story = Factory(:user_story, :status => "inactive")
      sign_in_a_user
    end

    # This should return the minimal set of attributes required to create a valid
    # UserStory. As you add validations to UserStory, be sure to
    # update the return value of this method accordingly.
    def valid_attributes
      Factory.attributes_for(:user_story)
    end

    describe "GET index" do
      it "assigns all user_stories as @user_stories" do
        get :index
        assigns(:user_stories).should eq([@user_story])
      end
    end

    describe "GET show" do
      it "assigns the requested @user_story as @@user_story" do
        get :show, :id => @user_story.id
        assigns(:user_story).should eq(@user_story)
      end
    end

    describe "GET new" do
      it "assigns a new @user_story as @@user_story" do
        get :new
        assigns(:user_story).should be_a_new(UserStory)
      end
    end

    describe "GET edit" do
      it "assigns the requested @user_story as @@user_story" do
        get :edit, :id => @user_story.id
        assigns(:user_story).should eq(@user_story)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new UserStory" do
          expect {
            post :create, :user_story => valid_attributes
          }.to change(UserStory, :count).by(1)
        end

        it "assigns a newly created @user_story as @@user_story" do
          post :create, :user_story => valid_attributes
          assigns(:user_story).should be_a(UserStory)
          assigns(:user_story).should be_persisted
        end

        it "redirects to the created @user_story" do
          post :create, :user_story => valid_attributes
          response.should redirect_to(UserStory.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved @user_story as @@user_story" do
          # Trigger the behavior that occurs when invalid params are submitted
          UserStory.any_instance.stub(:save).and_return(false)
          post :create, :user_story => {}
          assigns(:user_story).should be_a_new(UserStory)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          UserStory.any_instance.stub(:save).and_return(false)
          post :create, :user_story => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested @user_story" do
          # Assuming there are no other user_stories in the database, this
          # specifies that the UserStory created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          UserStory.any_instance.should_receive(:update_attributes).with({'name' => 'Test'})
          put :update, :id => @user_story.id, :user_story => {'name' => 'Test'}
        end

        it "assigns the requested @user_story as @@user_story" do
          put :update, :id => @user_story.id, :user_story => valid_attributes
          assigns(:user_story).should eq(@user_story)
        end

        it "redirects to the @user_story" do
          put :update, :id => @user_story.id, :user_story => valid_attributes
          response.should redirect_to(@user_story)
        end
      end

      describe "with invalid params" do
        it "assigns the @user_story as @@user_story" do
          # Trigger the behavior that occurs when invalid params are submitted
          UserStory.any_instance.stub(:save).and_return(false)
          put :update, :id => @user_story.id, :user_story => {}
          assigns(:user_story).should eq(@user_story)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          UserStory.any_instance.stub(:save).and_return(false)
          put :update, :id => @user_story.id, :user_story => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested @user_story" do
        expect {
          delete :destroy, :id => @user_story.id
        }.to change(UserStory, :count).by(-1)
      end

      it "redirects to the user_stories list" do
        delete :destroy, :id => @user_story.id
        response.should redirect_to(user_stories_url)
      end
    end

    describe "POST start" do
      before{ @user = Factory(:user) }
      it "changes user story status to active" do
        post :start, :id => @user_story.id, :user_id => @user.id
        UserStory.find(@user_story.id).status.should == "active"
      end

      it "assigns user story to user" do
        test_sign_in(@user)
        post :start, :id => @user_story.id, :user_id => @user.id
        UserStory.find(@user_story.id).user.should == @user
      end

      it "redirect to user story's page" do
        post :start, :id => @user_story.id, :user_id => @user.id
        response.should redirect_to(@user_story)
      end
    end

    describe "POST complete" do
      it "changes user story status to completed" do
        post :complete, :id => @user_story.id
        UserStory.find(@user_story.id).status.should == "completed"
      end
    end

  end

  describe "No action should be accessible without a logged in user" do

    it "can't access new" do
      get :new
      response.should redirect_to signin_path
    end

    it "can't access create" do
      post :create
      response.should redirect_to signin_path
    end

    it "can't access index" do
      get :index
      response.should redirect_to signin_path
    end

    it "can't access edit" do
      get :edit, id: 1
      response.should redirect_to signin_path
    end

    it "can't access update" do
      put :update, id: 1
      response.should redirect_to signin_path
    end

    it "can't access destroy" do
      delete :destroy, id: 1
      response.should redirect_to signin_path
    end

    it "can't access show" do
      get :show, id: 1
      response.should redirect_to signin_path
    end

    it "can't access start" do
      post :start, id: 1
      response.should redirect_to signin_path
    end

    it "can't acces complete" do
      post :complete, id: 1
      response.should redirect_to signin_path
    end

  end

end

