require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = Factory(:project)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@project.title)
    rendered.should match(@project.description)
    rendered.should match(@project.repository_url)
  end
end

