class UserStory < ActiveRecord::Base
  belongs_to :user

  # just the name is needed, as sometimes one wants to add a new user story fast
  # without description etc.

  validates :name, presence: true
  validates_inclusion_of :status, :in => ["active", "inactive", "completed"]

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
#

