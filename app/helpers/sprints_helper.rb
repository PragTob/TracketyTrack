module SprintsHelper

  def form_action_for_sprint(sprint)
    if sprint.new_record?
      "Start"
    else
      "Edit"
    end
  end

end

