require 'travis'

module TravisHelper

  def github_repo?
    project.repository_url =~ /github.com/ if project.repository_url
  end

  def owner_and_name
    match ||= project.repository_url.match(/github.com[:|\/]([^.]+)[.git]?/)
    if match
      match.captures.first
    else
      ""
    end
  end

  def check_travis_repo
    # don't check too frequently (timeout error)
    # nil for never checked
    if github_repo? &&
        (travis_last_updated == nil || travis_last_updated <= 1.day.ago)
      check_travis_api
    else
      nil
    end
  end

  def update_travis_ci_repo(repo_name)
    self.travis_ci_repo = repo_name
    self.travis_last_updated = DateTime.now
    save
  end

  def check_travis_api
    begin
      repo_name = owner_and_name
      if Travis::API::Client::Repositories.slug(repo_name).fetch
        update_travis_ci_repo repo_name
        repo_name
      else
        nil
      rescue
        puts "WWWOOOAAAHHH ERROR"
        nil
      end
    rescue SocketError
      logger.error "No internet connection?"
      nil
    rescue Timeout::Error
      logger.error "Timeout when accessing TravisAPI"
      nil
    rescue Errno::ECONNRESET
      logger.error "Connection reset by peer when accessing TravisAPI"
      nil
    end
  end
end

