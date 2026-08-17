FactoryBot.define do
  factory :patient do
    full_name { "Test Patient" }
    date_of_birth { Date.new(1990, 1, 1) }
    sequence(:email) { |n| "patient#{n}@example.com" }
  end
end
