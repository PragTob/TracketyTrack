require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = Factory(:project)
    @sprint = Factory(:sprint, end_date: DateTime.now)
    @sprint.stub(actual_velocity: 100)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(@project.title)
    rendered.should match(@project.description)
    rendered.should match(@project.repository_url)
  end
end

