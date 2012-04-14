def test_sign_in(user)
  controller.sign_in(user)
end

def sign_in_a_user
  user = FactoryGirl.build(:user)
  test_sign_in user
end

def sign_in_a_saved_user
  user = FactoryGirl.create :user
  test_sign_in user
end
