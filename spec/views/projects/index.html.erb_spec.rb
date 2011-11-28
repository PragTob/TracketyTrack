require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    @project = Factory(:project)
    assign(:projects, [@project, @project])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @project.title, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @project.description, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @project.repository_url, :count => 2
  end
end

