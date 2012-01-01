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
    self.work_effort = 0 unless work_effort
  end

  # just the name is needed, as sometimes one wants to add a new user story fast
  # without description etc.

  validates :name, presence: true
  validates_inclusion_of :status, in: STATUSES
  validates :work_effort, presence: true

  def self.backlog
    self.where sprint_id: nil, status: OPEN_STATUSES
  end

  def self.current_sprint_stories
    project = Project.current
    if project.has_current_sprint?
      self.where sprint_id: project.current_sprint, status: OPEN_STATUSES
    else
      []
    end
  end

  def self.completed_stories
    self.where status: UserStory::COMPLETED
  end

  def self.non_estimated
    self.where estimation: nil, status: OPEN_STATUSES
  end

  def self.work_in_progress_stories
    self.where status: UserStory::ACTIVE
  end

  def self. deleted
    self.where status: UserStory::DELETED
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
    self.close_time = DateTime.now.utc
    set_new_work_effort
    save
  end

  def printable_work_effort
    if work_effort
      "%d days %02d:%02d:%02d" % self.split_work_effort
    end
  end

  # TODO there has got to be a better way for this
  def split_work_effort
    if work_effort
      first_day = Time.at(0).gmtime.to_date
      spend_time = Time.at(work_effort).gmtime
      days = spend_time.to_date.mjd - first_day.mjd
      hours = spend_time.hour
      minutes = spend_time.min
      seconds = spend_time.sec
      return [days, hours, minutes, seconds]
    else
      return [0,0,0,0]
    end
  end

  def combine_work_effort days, hours, minutes, seconds
    self.work_effort = days * 86400 + hours * 3600 + minutes * 60 + seconds
    save
  end

  def delete
    self.status = DELETED
    save
  end

  def resurrect
    self.status = INACTIVE if self.status == DELETED
    save
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
#  close_time          :datetime
#

