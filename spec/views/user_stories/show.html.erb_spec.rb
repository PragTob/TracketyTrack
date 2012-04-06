require 'spec_helper'

describe "user_stories/show" do
  before(:each) do
    @user_story = Factory(:user_story, status: "inactive")
    @user = Factory(:user)
    @user_story.users << @user
    view.stub!(current_user: @user)
    assign(:comment, Comment.new)
  end

  let(:page) { Capybara::Node::Simple.new(rendered) }

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
    @comment = FactoryGirl.build :comment
    @user_story.comments  << @comment
    render
    rendered.should match @comment.content
    rendered.should match /Deleted User/i
  end

  it "has a button to request feedback" do
    render
    rendered.should match /Request Feedback/i
  end

  it "has a button to stop requesting feedback when, requesting feedback" do
    @user_story.requesting_feedback = true
    render
    rendered.should match /Stop Requesting Feedback/i
  end

end

