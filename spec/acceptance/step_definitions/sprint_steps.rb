steps_for :sprint do
  step "I start a sprint on the current sprint page" do
    visit current_sprint_path
    click_on "Start Sprint"
    fill_in "Number", with: "1"
    click_on "Start Sprint"
  end
end

