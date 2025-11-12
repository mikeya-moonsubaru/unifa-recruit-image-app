FactoryBot.define do
  factory :user do
    user_credential { build(:user_credential) }

    trait :with_connection do
      user_connection { build(:user_connection) }
    end
  end
end
