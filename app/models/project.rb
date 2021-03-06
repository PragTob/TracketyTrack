require_relative 'null/null_sprint'

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
  include StatisticsHelper

  attr_accessible :title, :description, :repository_url, :current_sprint

  has_one :project_settings
  after_initialize :init

  def init
    self.project_settings = ProjectSettings.new unless project_settings
  end

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
    save
  end

  def self.current
    first
  end

  def has_current_sprint?
    current_sprint_id != nil
  end

  #statistics

  def average_velocity
    completed_sprints = Sprint.completed_sprints
    if completed_sprints.empty?
      0
    else
      sum_of_velocities = completed_sprints.inject(0) do |sum, sprint|
        sum + sprint.actual_velocity
      end
      sum_of_velocities/completed_sprints.size
    end
  end

  def initial_story_points
    estimated_user_stories = UserStory.all - UserStory.non_estimated
    estimated_user_stories.inject(0) do |sum, user_story|
      sum + user_story.estimation.to_i
    end
  end

  def completed_story_points_per_sprint
    story_points_per_sprint = {}
    Sprint.completed_sprints.each do | sprint |
      story_points_per_sprint[sprint.number] = sprint.actual_velocity
    end
    story_points_per_sprint
  end

  def burndown_graph
    generate_burndown_chart(completed_story_points_per_sprint,
                        initial_story_points,
                        "Unfinished Story Points per completed Sprint")
  end

  def burnup_graph
    # TODO: add line of total amount of story points to finish
    generate_burnup_chart(completed_story_points_per_sprint,
                        "Finished Story Points per completed Sprint",
                        all_story_points_per_sprint)
  end

  def all_story_points_per_sprint
    story_points_per_sprint = {}
    Sprint.completed_sprints.each do | sprint |
      total_amount_of_story_points = 0
      UserStory.all.each do | user_story |
        if user_story.estimation && user_story.created_at <= sprint.end_date
          total_amount_of_story_points += user_story.estimation
        end
      end
      story_points_per_sprint[sprint.number] = total_amount_of_story_points
    end
    story_points_per_sprint
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

