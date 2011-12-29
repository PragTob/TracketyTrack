class UserStory < ActiveRecord::Base
  has_and_belongs_to_many :users, uniq: true
  belongs_to :sprint
  after_initialize :init

  ACTIVE        = "active"
  INACTIVE      = "inactive"
  COMPLETED     = "completed"
  SUSPENDED     = "suspended"
  DELETED       = "deleted"
  OPEN_STATUSES = [ACTIVE, INACTIVE, COMPLETED, SUSPENDED]
  STATUSES      = OPEN_STATUSES + [DELETED]

  def init
    self.status = INACTIVE unless status
    self.work_effort = 0
  end

  # just the name is needed, as sometimes one wants to add a new user story fast
  # without description etc.

  validates :name, presence: true
  validates_inclusion_of :status, in: STATUSES
  validates :work_effort, presence: true

  def self.backlog
    self.where(sprint_id: nil)
  end

  def self.current_sprint_stories
    project = Project.current
    if project.has_current_sprint?
      self.where(sprint_id: project.current_sprint, status: OPEN_STATUSES)
    else
      []
    end
  end

  def self.completed_stories
    self.where(status: UserStory::COMPLETED)
  end

  def self.non_estimated
    self.where(estimation: nil, status: OPEN_STATUSES)
  end

  def self.work_in_progress_stories
    self.where(status: UserStory::ACTIVE)
  end

  def short_description
    self.description[0..199]
  end

  def set_new_work_effort
    self.work_effort += DateTime.now.utc.to_i - self.start_time.to_i
  end

  def start user
    self.status = ACTIVE
    self.start_time = DateTime.now.utc
    self.users << user
    user.user_stories << self
    save
    user.save
  end

  def pause
    self.status = SUSPENDED
    set_new_work_effort
    save
  end

  def complete
    self.status = COMPLETED
    set_new_work_effort
    save
  end

  # TODO there has got to be a better way for this
  def printable_work_effort
    if work_effort
      time = work_effort
      days = time/86400.to_i
      hours = (time/3600 - days * 24).to_i
      minutes = (time/60 - (hours * 60 + days * 1440)).to_i
      seconds = (time - (minutes * 60 + hours * 3600 + days * 86400))
      "%d days %02d:%02d:%02d" % [days, hours, minutes, seconds]
    end
  end

  def delete
    self.status = DELETED
  end

  def resurrect
    self.status = INACTIVE if self.status == DELETED
  end

  # excludes all closed user stories (as a difference to all)
  def self.all_open
    self.where(status: OPEN_STATUSES)
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
#  sprint_id           :integer
#  work_effort         :integer
#  start_time          :datetime
#

