class ProjectsController < ApplicationController
  before_filter :authenticate, only: [:edit, :destroy, :update]

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])

    if @project.save
      redirect_to new_user_path, 
                  flash: { success: 'Project was successfully created.' }
    else
      render action: "new"
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(params[:project])
      redirect_to @project, 
                  flash: {success: 'Project was successfully updated.'}
    else
      render action: "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_url
  end
end

