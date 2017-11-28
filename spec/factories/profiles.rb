FactoryBot.define do
  factory :profile do
    trait :participant do
      name 'participante'
    end
    trait :organizer do
      name 'organizador'
    end
    trait :voluntary do
      name 'voluntário'
    end
    trait :speaker do
      name 'palestrante'
      has_theme true
    end
  end
end
