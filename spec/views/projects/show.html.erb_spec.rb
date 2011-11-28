require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = Factory(:project)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@project.title)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@project.description)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@project.repository_url)
  end
end

