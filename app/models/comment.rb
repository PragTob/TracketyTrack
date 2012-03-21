require_relative 'null/deleted_user'

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_story

  attr_accessible :date, :content, :user_story_id, :user_story

  validates :date, presence: true
  after_initialize :init

  def init
    self.date = DateTime.now
  end

  def user
    if commenter = super
      commenter
    else
      DeletedUser.new
    end
  end

end

# == Schema Information
#
# Table name: comments
#
#  id            :integer         not null, primary key
#  user_story_id :integer
#  user_id       :integer
#  date          :datetime
#  content       :text
#  created_at    :datetime
#  updated_at    :datetime
#

