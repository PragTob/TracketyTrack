module CurrentHelper

  def current_project
    @current_project ||= Project.current
  end

  def current_sprint
    @current_sprint ||= current_project.current_sprint
  end

  def current_sprint= sprint
    current_project.current_sprint = sprint
  end

end

