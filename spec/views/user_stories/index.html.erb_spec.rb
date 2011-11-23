require 'spec_helper'

describe "user_stories/index.html.erb" do
  before(:each) do
    assign(:user_stories, [
      stub_model(UserStory,
        :name => "Name",
        :description => "MyText",
        :acceptance_criteria => "MyAcceptanceCriteria",
        :priority => "1",
        :estimation => "2"
      ),
      stub_model(UserStory,
        :name => "Name",
        :description => "MyText",
        :acceptance_criteria => "MyAcceptanceCriteria",
        :priority => "1",
        :estimation => "2"
      )
    ])
  end

  it "renders a list of user_stories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyAcceptanceCriteria".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "2".to_s, :count => 2
  end
end

