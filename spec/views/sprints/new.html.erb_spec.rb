require 'spec_helper'

describe "sprints/new.html.erb" do
  before(:each) do
    assign(:sprint, stub_model(Sprint,
      :number => 1,
      :velocity => 1
    ).as_new_record)
  end

  it "renders new sprint form" do
    render

    assert_select "form", :action => sprints_path, :method => "post" do
      assert_select "input#sprint_number", :name => "sprint[number]"
      assert_select "input#sprint_velocity", :name => "sprint[velocity]"
    end
  end
end

