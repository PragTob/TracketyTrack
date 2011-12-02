class ProjectValidator < ActiveModel::Validator
  def validate(record)
    if Project.count > 1
      record.errors.add(:base,
                        "It is not possible to create more than one project")
    end
  end
end

class Project < ActiveRecord::Base
  include ActiveModel::Validations

  def current_sprint
    if current_sprint_id.nil?
      nil
    else
      Sprint.find(current_sprint_id)
    end
  end

  def current_sprint=(sprint)
    current_sprint_id = sprint.id
  end

  validates_with ProjectValidator
  validates :title, presence: true
end

