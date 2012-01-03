require 'spec_helper'

describe "comments/index.html.erb" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment,
        :user_story_id => 1,
        :user_id => 2,
        :content => "MyText"
      ),
      stub_model(Comment,
        :user_story_id => 1,
        :user_id => 2,
        :content => "MyText"
      )
    ])
  end

  it "renders a list of comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

