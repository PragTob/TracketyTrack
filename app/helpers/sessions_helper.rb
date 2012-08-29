module SessionsHelper

  def current_user
    @current_user ||= user_from_remember_token
  end

  def authenticate
    deny_access unless signed_in?
  end

  def current_user? user
    current_user == user
  end

  private

  def deny_access
    redirect_to signin_path, notice: "Please sign in to access this page."
  end

end

