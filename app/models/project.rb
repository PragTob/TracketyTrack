class ProjectValidator < ActiveModel::Validator
  def validate(record)
    if Project.count > 1
      record.errors.add(:base, "It is not possible to create more than one project")
    end
  end
end

class Project < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with ProjectValidator
  validates :title, :presence => true
end

