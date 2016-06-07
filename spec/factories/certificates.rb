FactoryGirl.define do
  factory :certificate do
    trait :future do
      title 'O que será do futuro no passado?'
      initial_date '2016-06-05'
      final_date '2016-06-05'
      workload 8
      local 'Hotel Martan Dourado, Rio de Janeiro - RJ'
      site 'http://www.o-que-sera-do-futuro.com.br'
    end
  end
end
