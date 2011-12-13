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
  has_many :user_stories

  validates :number,  presence: true,
                      uniqueness: true
  validates_with SprintDatesValidator
  validates_numericality_of :velocity, greater_than: 0

  def self.actual_sprint?
    not Sprint.actual_sprint.nil?
  end

  def self.actual_sprint
    time = DateTime.now
    Sprint.where("start_date <= ? AND end_date >= ?", time, time).first
  end

end

