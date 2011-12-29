require 'spec_helper'

describe CurrentHelper do

  before :each do
    @project = Factory(:project)
  end

  it "returns the current project" do
    current_project.should eq @project
  end

  describe "current sprint" do

    before :each do
      @sprint = Factory(:sprint)
      @project.current_sprint = @sprint
    end

    it "returns the current sprint" do
      current_sprint.should eq @sprint
    end

    it "can be modified" do
      current_sprint.number = 99
      current_sprint.save
      Sprint.find(current_sprint.id).number.should eq 99
    end

  end


  it "sets the current sprint" do
    @sprint = Factory(:sprint)
    self.current_sprint = @sprint
    current_sprint.should eq @sprint
  end

end

