require 'spec_helper'

describe "projects/new.html.erb" do
  before(:each) do
    assign(:project, stub_model(Project,
      :titel => "MyString",
      :description => "MyText",
      :repository_url => "MyString"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_titel", :name => "project[titel]"
      assert_select "textarea#project_description", :name => "project[description]"
      assert_select "input#project_repository_url", :name => "project[repository_url]"
    end
  end
end
