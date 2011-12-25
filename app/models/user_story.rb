class UserStory < ActiveRecord::Base
  has_and_belongs_to_many :users, uniq: true
  belongs_to :sprint

  # just the name is needed, as sometimes one wants to add a new user story fast
  # without description etc.

  validates :name, presence: true
  validates_inclusion_of :status, :in => ["inactive", "active",
                                          "suspended", "completed"]
  validates :work_effort, presence: true

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

  def set_new_work_effort
    self.work_effort += DateTime.now.utc.to_i - self.start_time.to_i
  end

  def printable_work_effort
     time = self.work_effort
     days = time/86400.to_i
     hours = (time/3600 - days * 24).to_i
     minutes = (time/60 - (hours * 60 + days * 1440)).to_i
     seconds = (time - (minutes * 60 + hours * 3600 + days * 86400))
     "%d days %02d:%02d:%02d" % [days, hours, minutes, seconds]
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

