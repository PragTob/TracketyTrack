class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_story

  validates :date, presence: true

end

