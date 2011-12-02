class SprintDatesValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date > record.end_date
      record.errors.add(:base,
                        "The end date must not lie before the start date.")
    end
  end
end

class Sprint < ActiveRecord::Base
  has_many :user_stories

  validates :number,  presence: true,
                      uniqueness: true
  validates_with SprintDatesValidator
  validates_numericality_of :velocity, greater_than: 0

end

