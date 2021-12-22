FactoryBot.define do
  factory :template do
    trait :fisl do
      name { 'FISL 10' }
      font_color { '#000000' }
      image { File.new(FileImage.dummy_template) }
    end
  end
end
