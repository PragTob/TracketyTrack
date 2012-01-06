step "there is a user story" do
  @user_story = Factory(:user_story)
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

step "I should see this user story in the user story overview" do
  visit user_stories_path
  page.should have_content(@user_story.name)
end

