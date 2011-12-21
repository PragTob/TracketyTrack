module SprintsHelper

  def form_action_for(sprint)
    if sprint.new_record?
      "Start"
    else
      "Edit"
    end
  end

end

