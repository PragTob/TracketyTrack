module UsersHelper

  def set_accepted(user)
    # the first user is always authorized as he created the project
    if User.all.empty?
      user.accepted = true
    else
      user.accepted = false
    end
  end

  def gravatar_for(user, options = { size: 120 })
    gravatar_image_tag(user.email.downcase, alt: user.name + "'s picture",
                                            gravatar: options)
  end

  def mini_gravator_for(user)
    gravatar_for(user, { size: 20 })
  end

  def form_action_for_user(user)
    if user.new_record?
      "Register now"
    else
      "Edit my profile"
    end
  end

end

