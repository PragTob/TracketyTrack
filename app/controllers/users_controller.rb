class UsersController < ApplicationController
  include UsersHelper

  before_filter :authenticate, except: [:new, :create]
  before_filter :only_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.accepted_users
    @unaccepted_users = User.unaccepted_users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    set_accepted(@user)

    if @user.password_valid? && @user.save
        redirect_to signin_path,
                    flash: {success: 'User was successfully created.'}
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]

    if @user.password_valid? && @user.save
      redirect_to @user,
                    flash: {success: 'User was successfully updated.'}
    else
      render action: "edit"
    end
  end

  def destroy
    sign_out
    @user = User.find(params[:id])
    @user.destroy

    bye_message = "It is unfortunate, that you don't want to work on /" +
                  current_project.title + "any more! We will miss you!"
    redirect_to root_url, notice: bye_message
  end

  def accept_user
    @user = User.find(params[:id])
    @user.accept

    redirect_to users_path, flash:
                { success: 'The user has been accepted to join your project!' }
  end

  private
  def only_current_user
    user = User.find(params[:id])
    error_message = "You don't have the permission to alter the profile of somebody else"
    redirect_to user, flash:{error: error_message}  unless current_user? user
  end

end

