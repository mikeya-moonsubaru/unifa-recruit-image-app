module ApplicationHelper
  def tweet_authenticated?
    Current.user&.user_connection&.tweet_access_token.present?
  end
end
