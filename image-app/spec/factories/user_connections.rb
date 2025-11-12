FactoryBot.define do
  factory :user_connection do
    user { build(:user) }
    tweet_access_token { "test_access_token" }
  end
end
