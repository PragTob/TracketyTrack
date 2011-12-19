class SprintDatesValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date > record.end_date
      record.errors.add(:base,
                        "The end date must not lie before the start date.")
    end
    Sprint.all.each do |sprint|
      if (sprint.start_date <= record.start_date and
          record.start_date < sprint.end_date) or
         (sprint.start_date < record.end_date and
          record.end_date <= sprint.end_date) and
         sprint != record

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

