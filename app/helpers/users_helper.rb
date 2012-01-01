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
    gravatar_image_tag(user.email.downcase, alt: user.name,
                                            gravatar: options)
  end

end

