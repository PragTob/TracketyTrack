steps_for :project do
  step "I enter the project data" do
    @project = Factory.build :project
    fill_in "Title", with: @project.title
    fill_in "Description", with: @project.description
    click_on "Create Project"
  end
end

