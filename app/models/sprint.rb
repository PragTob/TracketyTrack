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
    not Sprint.actual_sprint.nil?
  end

  def self.actual_sprint
    time = DateTime.now
    Sprint.where("start_date <= ? AND end_date >= ?", time, time).first
  end

  def user_stories_not_in_progress
    user_stories.select do |each|
      each.status == "inactive" or each.status == "completed"
    end
  end

  def user_stories_in_progress
    user_stories.select do |each|
      each.status == "active" or each.status == "suspended"
    end
  end

  def end
    self.end_date = DateTime.now
    self.save
  end

  def expired?
    self.end_date < DateTime.now
  end

end

# == Schema Information
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  number     :integer
#  start_date :datetime
#  end_date   :datetime
#  velocity   :integer
#  created_at :datetime
#  updated_at :datetime
#

