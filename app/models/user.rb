require 'digest'

class User < ActiveRecord::Base
  has_many :projects
  has_and_belongs_to_many :user_stories, uniq: true
  has_many :comments

  attr_accessor :password, :password_confirmation
  attr_accessible :name, :email, :description, :password, :password_confirmation

  validates :name,  presence: true
  validates :email, presence: true,
                    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                    uniqueness: true,
                    on: :create

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

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

  def password_valid?
    if password.blank? || !(8..40).include?(password.size)
      self.errors.add :password,
                      "The password is not within 8 to 40 characters"
      false
    else
      if  password != password_confirmation
        self.errors.add :password_confirmation,
                        "The password confirmation does not match the password."
        false
      else
        true
      end
    end
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password) unless password.blank?
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
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

