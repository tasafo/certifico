FactoryGirl.define do
  factory :user do
    password '123456'

    trait :paul do
      email 'paul@example.org'
      full_name 'Paulo Moura'
      user_name 'paulo'
    end

    trait :billy do
      email 'billy@example.org'
      full_name 'Billy Blay'
      user_name 'billy'
    end

    trait :luis do
      email 'luiz@example.org'
      full_name 'Luiz Sanches'
      user_name 'luiz'
    end
  end
end
