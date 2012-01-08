class SprintDatesValidator < ActiveModel::Validator

  def validate(record)
    # for now if the end_date is not given we don't perform this validation
    # TODO how useful is a validation in this case?
    if record.end_date
      check_start_before_end record
      check_overlapping_sprints record
    end
  end

  private

  def check_start_before_end record
    if record.start_date > record.end_date
      record.errors.add(:base,
                        "The end date must not lie before the start date.")
    end
  end

  def check_overlapping_sprints record
    sprints_without_record = Sprint.all - [record]
    sprints_without_record.each do |sprint|
      if (sprint.start_date <= record.start_date and
          record.start_date < sprint.end_date) or
         (sprint.start_date < record.end_date and
          record.end_date <= sprint.end_date)

        record.errors.add(:base,
                          "Sprint dates must not overlapp with other sprints.")
      end
    end
  end

end

class Sprint < ActiveRecord::Base
  has_many :user_stories, uniq: true

  validates :number,  presence: true,
                      uniqueness: true
  validates_with SprintDatesValidator
  validates :velocity,  numericality: {greater_than: 0}, allow_nil: true

  def self.actual_sprint?
    not actual_sprint.nil?
  end

  def self.actual_sprint
    time = DateTime.now
    where("start_date <= ? AND end_date >= ?", time, time).first
  end

  def self.completed_sprints
    all.reject { |sprint| sprint.end_date.nil? }
  end

  def user_stories_not_in_progress
    user_stories.select do |each|
      each.status == "inactive" or each.status == "completed"
    end
  end

  def user_stories_completed
    user_stories.select do |each|
      each.status == "completed"
    end
  end

  def user_stories_estimated
    estimated = user_stories.reject { |user_story| user_story.estimation.nil? }
    estimated
  end

  def user_stories_in_progress
    user_stories.select do |each|
      each.status == "active" or each.status == "suspended"
    end
  end

  def user_stories_for_user(user)
    user_stories_in_progress.select do |each|
      each.users.include?(user)
    end
  end

  def end
    self.end_date = DateTime.now
    self.save
  end

  def expired?
    self.end_date < DateTime.now
  end

  # statistics

  def initial_story_points
    user_stories_estimated.inject(0) { |sum, each| sum + each.estimation }
  end

  def completed_story_points_per_day
    day_of_sprint = start_date.to_date
    story_points_per_day = {}
    final_date = DateTime.now.to_date
    final_date = end_date.to_date unless end_date.nil?
    while day_of_sprint <= final_date do
      story_points_per_day[day_of_sprint.to_s] = 0
      day_of_sprint += 1
    end
    user_stories_completed.each do |user_story|
        story_points_per_day[user_story.close_time.to_date.to_s] += user_story.estimation if user_story.estimation
    end
    story_points_per_day
  end

  def burndown_graph
    story_points = [initial_story_points]
    legend_dates = ['initial']
    completed_story_points_per_day.each do |date, story_points_of_day|
      story_points << (story_points.last - story_points_of_day)
      legend_dates << date.to_s
    end
    chart = Gchart.bar(
                data: story_points,
                axis_with_labels: ['x,y'],
                axis_labels: [legend_dates],
                axis_range: [nil, [0,initial_story_points,1]],
                legend: 'Story points of unfinished user stories',
                bar_width_and_spacing: {width: 35, spacing: 30},
                width: 1000)
    chart
  end

  def actual_velocity
    actual_velocity = 0
    user_stories.where(status: UserStory::COMPLETED).each do |user_story|
      actual_velocity += user_story.estimation if user_story.estimation
    end
    actual_velocity
  end

end

# == Schema Information
#
# Table name: sprints
#
#  id          :integer         not null, primary key
#  number      :integer
#  start_date  :datetime
#  end_date    :datetime
#  velocity    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

