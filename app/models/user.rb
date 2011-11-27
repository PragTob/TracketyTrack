class User < ActiveRecord::Base
  validates :name,  :presence => true
  validates :email, :presence => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                    :uniqueness => true, :on => :create
end
