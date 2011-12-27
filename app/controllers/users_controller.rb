class UsersController < ApplicationController
  include UsersHelper

  before_filter :authenticate, except: [:new, :create]

  def index
    @users = User.all
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

    respond_to do |format|
      if @user.password_valid? && @user.save
          format.html { redirect_to signin_path, flash: {success: 'User was successfully created.'} }
          format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]

    respond_to do |format|
      if @user.password_valid? && @user.save
        format.html { redirect_to @user,
                      flash: {success: 'User was successfully updated.'} }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def accept_user
    @user = User.find(params[:id])
    @user.accept

    redirect_to accept_url, flash:
                { success: 'The user has been accepted to join your project!' }
  end

  def accept
    @users = User.find_all_by_accepted(false)
  end

end

