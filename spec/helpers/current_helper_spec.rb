require 'spec_helper'

describe CurrentHelper do

  before :each do
    @project = Factory(:project)
  end

  it "returns the current project" do
    current_project.should eq @project
  end

  it "returns the current sprint" do
    @sprint = Factory(:sprint)
    @project.current_sprint = @sprint
    current_sprint.should eq @sprint
  end
end

