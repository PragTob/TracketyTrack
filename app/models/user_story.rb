class UserStory < ActiveRecord::Base
  include CurrentHelper
  belongs_to :user
  belongs_to :sprint

  # just the name is needed, as sometimes one wants to add a new user story fast
  # without description etc.

  validates :name, presence: true
  validates_inclusion_of :status, :in => ["inactive", "active", "suspended", "completed"]

  def self.backlog
    self.where(sprint_id: nil)
  end

  def self.current_sprint_stories
    # TODO: get project/current sprint from helper (or project model)
    unless Project.first.current_sprint.nil?
      self.where(sprint_id: Project.first.current_sprint)
    end
  end

  def self.completed_stories
    self.where(status: "completed")
  end

  def self.work_in_progress_stories
    self.where(status: "active")
  end

end
# == Schema Information
#
# Table name: user_stories
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  description         :text
#  acceptance_criteria :text
#  priority            :integer
#  estimation          :integer
#  created_at          :datetime
#  updated_at          :datetime
#

