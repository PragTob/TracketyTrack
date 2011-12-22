require_relative '../../lib/null_sprint'

class ProjectValidator < ActiveModel::Validator
  def validate(record)
    if Project.count >= 1
      record.errors.add(:base,
                        "It is not possible to create more than one project")
    end
  end
end

class Project < ActiveRecord::Base
  include ActiveModel::Validations

  def current_sprint
    if has_current_sprint?
      Sprint.find(current_sprint_id)
    else
      NullSprint.new
    end
  end

  def current_sprint=(sprint)
    if sprint.nil?
      self.current_sprint_id = nil
    else
      self.current_sprint_id = sprint.id
    end
    self.save
  end

  def self.current
    self.first
  end

  def has_current_sprint?
    current_sprint_id != nil
  end

  # there shall only be one project atm
  validates_with ProjectValidator, on: :create
  validates :title, presence: true
end

# == Schema Information
#
# Table name: projects
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  description       :text
#  repository_url    :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  current_sprint_id :integer
#

