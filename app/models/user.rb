require 'digest'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :projects
  has_and_belongs_to_many :user_stories, uniq: true
  has_many :comments

  attr_accessible :name, :email, :description

  validates :name,  presence: true
  validates :email, presence: true,
                    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                    uniqueness: true,
                    on: :create

  def accept
    self.accepted = true
    save
  end

  def self.accepted_users
    where(accepted: true)
  end

  def self.unaccepted_users
    where(accepted: false)
  end
end
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  description        :text
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  accepted           :boolean
#

