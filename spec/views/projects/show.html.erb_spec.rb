require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :titel => "Titel",
      :description => "MyText",
      :repository_url => "Repository Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Titel/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Repository Url/)
  end
end
