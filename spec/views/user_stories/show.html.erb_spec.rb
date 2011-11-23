require 'spec_helper'

describe "user_stories/show.html.erb" do
  before(:each) do
    @user_story = assign(:user_story, stub_model(UserStory,
      :name => "Name",
      :description => "MyText",
      :acceptance_criteria => "MyAcceptanceCriteria",
      :priority => "1",
      :estimation => "2"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/MyAcceptanceCriteria/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end

