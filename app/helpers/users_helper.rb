module UsersHelper

  def set_accepted(user)
    # the first user is always authorized as he created the project
    if User.all.empty?
      user.accepted = true
    else
      user.accepted = false
    end
  end

end

