FactoryGirl.define do
  factory :profile do
    trait :participant do
      name 'participante'
    end
    trait :speaker do
      name 'palestrante'
      has_theme true
    end
  end
end
