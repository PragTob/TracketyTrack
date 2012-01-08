require 'spec_helper'

describe "sprints/edit" do
  before(:each) do
    @sprint = assign(:sprint, stub_model(Sprint,
      :number => 1,
      :velocity => 1
    ))
  end

  it "renders the edit sprint form" do
    render

    assert_select "form", :action => sprints_path(@sprint), :method => "post" do
      assert_select "input#sprint_number", :name => "sprint[number]"
      assert_select "input#sprint_velocity", :name => "sprint[velocity]"
    end
  end
end

