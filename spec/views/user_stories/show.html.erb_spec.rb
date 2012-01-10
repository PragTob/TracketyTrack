require 'spec_helper'

describe "user_stories/show" do
  before(:each) do
    @user_story = Factory(:user_story, status: "inactive")
    @user = Factory(:user)
    @user_story.users << @user
    view.stub!(current_user: @user)
    assign(:comment, Comment.new)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@user_story.name)
    rendered.should match(@user_story.description)
    rendered.should match(@user_story.acceptance_criteria)
    rendered.should match(@user_story.priority.to_s)
    rendered.should match(@user_story.estimation.to_s)
  end

  it "renders all names of assignees" do
    render
    rendered.should match(@user.name)
  end

  it "states 'No user assigned' if no user is assigned" do
    @user_story.users = []
    render
    rendered.should match("No user assigned")
  end

  it "renders comments even without a user" do
    @comment = Factory.build :comment
    @user_story.comments  << @comment
    render
    rendered.should match @comment.content
    rendered.should match /Deleted User/i
  end

end

