# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
pt_BR = [
  {name: 'evento', preposition: 'do'},
  {name: 'encontro', preposition: 'do'},
  {name: 'simpósio', preposition: 'do'},
  {name: 'seminário', preposition: 'do'},
  {name: 'curso', preposition: 'do'},
  {name: 'semana', preposition: 'da'},
  {name: 'feira', preposition: 'da'},
  {name: 'oficina', preposition: 'da'}
]

en = [
  {name: 'event', preposition: 'the'},
  {name: 'meeting', preposition: 'the'},
  {name: 'symposium', preposition: 'the'},
  {name: 'seminar', preposition: 'the'},
  {name: 'course', preposition: 'the'},
  {name: 'week', preposition: 'the'},
  {name: 'fair', preposition: 'the'},
  {name: 'workshop', preposition: 'the'}
]

es = [
  {name: 'evento', preposition: 'el'},
  {name: 'reunión', preposition: 'el'},
  {name: 'simposio', preposition: 'el'},
  {name: 'seminario', preposition: 'el'},
  {name: 'curso', preposition: 'el'},
  {name: 'semana', preposition: 'la'},
  {name: 'feria', preposition: 'la'},
  {name: 'taller', preposition: 'la'}
]

0.upto(7) do |index|
  I18n.locale = 'pt-BR'
  category = Category.new
  category.name = pt_BR[index][:name]
  category.preposition = pt_BR[index][:preposition]

  I18n.locale = :en
  category.name = en[index][:name]
  category.preposition = en[index][:preposition]

  I18n.locale = :es
  category.name = es[index][:name]
  category.preposition = es[index][:preposition]

  category.save
end
