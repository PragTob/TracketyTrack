module SprintsHelper

  def form_action_for_sprint(sprint)
    if sprint.new_record?
      "Start"
    else
      "Edit"
    end
  end

  def delete_sprint(sprint)
    if self.current_sprint == sprint
      self.current_project.current_sprint = nil
    end
  end

end

