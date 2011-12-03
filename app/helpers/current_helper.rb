module CurrentHelper

  def current_project
    @current_project ||= Project.first
  end

  def current_sprint
    current_project.current_sprint
  end

end

