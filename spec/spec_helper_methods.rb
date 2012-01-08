def test_sign_in(user)
  controller.sign_in(user)
end

def sign_in_a_user
  user = Factory.build(:user)
  test_sign_in user
end

def sign_in_a_saved_user
  user = Factory :user
  test_sign_in user
end
