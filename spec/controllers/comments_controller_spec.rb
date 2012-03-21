require 'spec_helper'

describe CommentsController do

  def valid_attributes
    FactoryGirl.attributes_for(:comment)
  end

  describe "POST create" do
    describe "with valid params" do

      before :each do
        @user_story = Factory(:user_story)
        @user = Factory(:other_user)
        test_sign_in @user
      end

      it "creates a new Comment" do
        expect {
          post :create, :comment =>
                          valid_attributes.merge(user_story_id: @user_story.id)
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, :comment =>
                          valid_attributes.merge(user_story_id: @user_story.id)
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "sets the current date" do
        time = DateTime.now
        Timecop.freeze time
        post :create, :comment =>
                          valid_attributes.merge(user_story_id: @user_story.id)
        assigns(:comment).date.to_i.should eq time.to_i
      end

      it "sets the current user as author" do
        post :create, :comment =>
                          valid_attributes.merge(user_story_id: @user_story.id)
        assigns(:comment).user.should eq @user
      end

      it "assings the comment to the corresponding user story" do
        post :create, :comment =>
                          valid_attributes.merge(user_story_id: @user_story.id)
        assigns(:comment).user_story.should eq @user_story
      end

      it "redirects to the corresponding user story" do
        post :create, :comment =>
                          valid_attributes.merge(user_story_id: @user_story.id)
        response.should redirect_to(@user_story)
      end
    end

    describe "with invalid params" do
      
      before :each do
        # lil hack since request.referrer isn't set
        @user_story = Factory :user_story
        controller.request.stub(referrer: user_story_path(@user_story))
      end
      
      it "assigns a newly created but unsaved comment as @comment" do
        Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {}
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {}
        response.should redirect_to user_story_path(@user_story)
      end
    end
  end

  describe "DELETE destroy" do

    before :each do
      @user_story = Factory(:user_story)
    end

    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes.merge(user_story: @user_story)
      expect {
        delete :destroy, :id => comment.id
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the corresponding user story" do
      comment = Comment.create! valid_attributes.merge(user_story: @user_story)
      delete :destroy, :id => comment.id
      response.should redirect_to(@user_story)
    end
  end

end

