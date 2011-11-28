require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :titel => "Titel",
        :description => "MyText",
        :repository_url => "Repository Url"
      ),
      stub_model(Project,
        :titel => "Titel",
        :description => "MyText",
        :repository_url => "Repository Url"
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Titel".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Repository Url".to_s, :count => 2
  end
end
