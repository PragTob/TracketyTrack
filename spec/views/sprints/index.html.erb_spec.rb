require 'spec_helper'

describe "sprints/index" do

  before(:each) do
    assign(:sprints, [
      stub_model(Sprint,
        :number => 1,
        :velocity => 2
      ),
      stub_model(Sprint,
        :number => 1,
        :velocity => 2
      )
    ])
  end

  it "renders a list of sprints" do
    render
    assert_select "tr>td", :text => 'Sprint 1', :count => 2
  end

end

