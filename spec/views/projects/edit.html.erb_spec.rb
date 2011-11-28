require 'spec_helper'

describe "projects/edit.html.erb" do
  before(:each) do
    @project = Factory(:project)
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path(@project), :method => "post" do
      assert_select "input#project_title", :name => "project[title]"
      assert_select "textarea#project_description", :name => "project[description]"
      assert_select "input#project_repository_url", :name => "project[repository_url]"
    end
  end
end
