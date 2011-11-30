require 'spec_helper'

describe "layouts/application.html.erb" do

  it "contains a link to register a new user" do
    assign(:outlogged, true)
    render
    rendered.should have_link("Register", href: new_user_path)
  end

end

