FactoryBot.define do
  factory :patient do
    full_name { "Test Patient" }
    sequence(:email) { |n| "patient#{n}@example.com" }
  end
end
