FactoryBot.define do
  factory :template do
    trait :fisl do
      name { 'FISL 10' }
      font_color { '#000000' }
      image { File.new(ImageFile.dummy('templates', 'vaam.jpg')) }
    end
  end
end
