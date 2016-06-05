FactoryGirl.define do
  factory :user do
    trait :paul do
      email 'paul@example.org'
      password '123456'
    end

    trait :billy do
      email 'billy@example.org'
      password '123456'
    end
  end
end
