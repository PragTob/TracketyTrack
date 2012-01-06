steps_for :user do

  step "I enter my user data" do
    @user = Factory.build :user
    fill_in 'Name', with: @user.name
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password confirmation', with: @user.password
    click_on 'Register now'
  end

  step "I log in" do
    visit signin_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Sign in'
  end

end

