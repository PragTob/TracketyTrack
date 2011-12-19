class UserStory < ActiveRecord::Base
  has_and_belongs_to_many :users, uniq: true
  belongs_to :sprint

  # just the name is needed, as sometimes one wants to add a new user story fast
  # without description etc.

  validates :name, presence: true
  validates_inclusion_of :status, :in => ["inactive", "active", "suspended", "completed"]

  def self.backlog
    self.where(sprint_id: nil)
  end

  def self.current_sprint_stories
    project = Project.current
    self.where(sprint_id: project.current_sprint) if project.has_current_sprint?
  end

  def self.completed_stories
    self.where(status: "completed")
  end

  def self.work_in_progress_stories
    self.where(status: "active")
  end

  def short_description
    self.description[0..199]
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
#  status              :string(255)
#  user_id             :integer
#  sprint_id           :integer
#

