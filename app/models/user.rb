class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :projects

  validates :name,  presence: true
  validates :email, presence: true,
                    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                    uniqueness: true,
                    on: :create
end
# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  email       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

