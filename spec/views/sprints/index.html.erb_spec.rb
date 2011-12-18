require 'spec_helper'

describe "sprints/index.html.erb" do
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
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end

end

