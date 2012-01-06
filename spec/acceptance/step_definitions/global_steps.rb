step "I am logged in" do
  @user = Factory :user
  visit signin_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_on 'Sign in'
end

step "there is a project" do
  @project = Factory :project
end

step "I am on the current sprint page" do
  visit current_sprint_path
end

step "I click on :name" do |name|
  click_on name
end

step "I should see a success notification" do
  find('div .success').should have_content 'success'
end

