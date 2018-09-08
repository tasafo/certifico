FactoryBot.define do
  factory :category do
    trait :event do
      name { 'Evento' }
      preposition { 'do' }
    end
  end
end
