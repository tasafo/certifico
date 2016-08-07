FactoryGirl.define do
  factory :user do
    password '123456'

    trait :paul do
      email 'paul@example.org'
    end

    trait :billy do
      email 'billy@example.org'
    end

    trait :luis do
      email 'luis@example.org'
    end
  end
end
