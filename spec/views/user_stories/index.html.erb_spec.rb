require 'spec_helper'

describe "user_stories/index.html.erb" do
  before(:each) do
    @user_story = Factory(:user_story)
    assign(:user_stories, [@user_story])
  end

  it "renders a list of user_stories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user_story.name.to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user_story.description.to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user_story.acceptance_criteria.to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user_story.priority.to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @user_story.estimation.to_s, :count => 1
  end
end

