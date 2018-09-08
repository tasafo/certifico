FactoryBot.define do
  factory :template do
    trait :fisl do
      name { 'FISL 10' }
      font_color { '#000000' }
      image { File.new("#{Rails.root}/spec/support/assets/images/vaam_template.jpg") }
    end
  end
end
