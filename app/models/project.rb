class Project < ActiveRecord::Base
  validates :title, :presence => true
end

