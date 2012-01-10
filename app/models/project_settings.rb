class ProjectSettings < ActiveRecord::Base
  include TravisHelper

  belongs_to :project

  def travis_ci_repo
    return check_travis_repo unless super
    super
  end

end

# == Schema Information
#
# Table name: project_settings
#
#  id                  :integer         not null, primary key
#  travis_ci_repo      :string(255)
#  travis_last_updated :datetime
#  project_id          :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

