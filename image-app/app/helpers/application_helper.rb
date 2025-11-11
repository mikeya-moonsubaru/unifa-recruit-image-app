module ApplicationHelper
  def tweet_authenticated?
    session[:tweet_access_token].present?
  end
end
