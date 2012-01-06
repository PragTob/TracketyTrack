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

step "there is a user story" do
  @user_story = Factory(:user_story)
end

step "I am on the current sprint page" do
  visit current_sprint_path
end

step "I click on :name" do |name|
  click_on name
end

step "I should see the name of the user story" do
  page.should have_content(@user_story.name)
end

step "I create a new user story" do
  @user_story = Factory.build(:user_story)
  visit new_user_story_path
  fill_in 'Name', with: @user_story.name
  click_on 'Create User story'
end

step "I should see a success notification" do
  find('div .success').should have_content 'success'
end

step "I should see this user story in the user story overview" do
  visit user_stories_path
  page.should have_content(@user_story.name)
end

