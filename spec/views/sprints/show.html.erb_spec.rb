require 'spec_helper'

describe "sprints/show.html.erb" do
  before(:each) do
    @sprint = assign(:sprint, stub_model(Sprint,
      :number => 1,
      :velocity => 1,
      :start_date => DateTime.now
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/1/)
    rendered.should match(/1/)
  end

end

