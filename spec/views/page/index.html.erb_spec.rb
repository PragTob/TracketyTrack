require 'spec_helper'

describe "page/index.html.erb" do

  before :all do
    @project = assign(:project, Factory.build(:project))
  end

  #it "displays the title of the current project" do
  #  render
  #  rendered.should match(@project.title)
  #end
end

