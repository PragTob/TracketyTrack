module TravisHelper

  require 'travis'

  def owner_and_name_from repo
    match = repo.match(/github.com[:|\/]([^.]+)[.git]?/)
    if match
      match.captures.first
    else
      nil
    end
  end

  def travis_repo_from repo
    owner_and_name = owner_and_name_from repo
    if owner_and_name
      travis_repo = Travis::API::Client::Repositories.slug(owner_and_name).fetch
      if travis_repo
        owner_and_name
      else
        nil
      end
    end
  end

end

