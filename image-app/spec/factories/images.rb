FactoryBot.define do
  factory :image do
    user
    title { "Test Image" }
    path { "test/image.jpg" }
  end
end
