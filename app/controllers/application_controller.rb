class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_topics = user.topics.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_entries = user.entries.count
  end
end