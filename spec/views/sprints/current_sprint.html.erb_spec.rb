require 'spec_helper'

describe "sprints/current_sprint.html.erb" do

  before :each do

    view.stub!(signed_in?: true)
    @user = Factory(:user)
    view.stub!(current_user: @user)
    @project = Factory(:project)
    view.stub!(current_project: @project)
    render

  end

  describe "when there is no current sprint" do

    it "shows a start sprint button" do
      rendered.should have_button("Start Sprint")
    end

    it "shows a notification that there is no current sprint" do
      rendered.should have_content "There is no current sprint. Please start a new one!"
    end

  end


end

