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
      begin
        if Travis::API::Client::Repositories.slug(owner_and_name).fetch
          owner_and_name
        else
          nil
        end
      # no internet connection
      rescue SocketError
        nil
      end
    end
  end

end

