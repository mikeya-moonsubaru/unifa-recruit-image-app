class UserConnection < ApplicationRecord
  belongs_to :user

  encrypts :tweet_access_token
end
