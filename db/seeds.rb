categories = {
  pt_BR: [
    {name: 'evento', preposition: 'do'},
    {name: 'encontro', preposition: 'do'},
    {name: 'simpósio', preposition: 'do'},
    {name: 'seminário', preposition: 'do'},
    {name: 'fórum', preposition: 'do'},
    {name: 'curso', preposition: 'do'},
    {name: 'conferência', preposition: 'da'},
    {name: 'semana', preposition: 'da'},
    {name: 'feira', preposition: 'da'},
    {name: 'oficina', preposition: 'da'}
  ],
  en: [
    {name: 'event', preposition: 'the'},
    {name: 'meeting', preposition: 'the'},
    {name: 'symposium', preposition: 'the'},
    {name: 'seminar', preposition: 'the'},
    {name: 'forum', preposition: 'the'},
    {name: 'course', preposition: 'the'},
    {name: 'conference', preposition: 'the'},
    {name: 'week', preposition: 'the'},
    {name: 'fair', preposition: 'the'},
    {name: 'workshop', preposition: 'the'}
  ],
  es: [
    {name: 'evento', preposition: 'en el'},
    {name: 'reunión', preposition: 'en el'},
    {name: 'simposio', preposition: 'en el'},
    {name: 'seminario', preposition: 'en el'},
    {name: 'foro', preposition: 'en el'},
    {name: 'curso', preposition: 'en el'},
    {name: 'conferencia', preposition: 'a la'},
    {name: 'semana', preposition: 'a la'},
    {name: 'feria', preposition: 'a la'},
    {name: 'taller', preposition: 'a la'}
  ]
}

0.upto(categories[:pt_BR].count - 1) do |index|
  I18n.locale = 'pt-BR'
  category = Category.new
  category.name = categories[:pt_BR][index][:name]
  category.preposition = categories[:pt_BR][index][:preposition]

  I18n.locale = :en
  category.name = categories[:en][index][:name]
  category.preposition = categories[:en][index][:preposition]

  I18n.locale = :es
  category.name = categories[:es][index][:name]
  category.preposition = categories[:es][index][:preposition]

  category.save
end

profiles = {
  pt_BR: [
    {name: 'organizador', has_theme: false},
    {name: 'palestrante', has_theme: true},
    {name: 'participante', has_theme: false},
    {name: 'coordenador', has_theme: true},
    {name: 'instrutor', has_theme: false},
    {name: 'professor', has_theme: false},
    {name: 'voluntário', has_theme: false}
  ],
  en: [
    {name: 'organizer'},
    {name: 'speaker'},
    {name: 'participant'},
    {name: 'coordinator'},
    {name: 'instructor'},
    {name: 'teacher'},
    {name: 'voluntary'}
  ],
  es: [
    {name: 'organizador'},
    {name: 'orador'},
    {name: 'partícipe'},
    {name: 'coordinador'},
    {name: 'entrenador'},
    {name: 'profesor'},
    {name: 'voluntario'}
  ]
}

0.upto(profiles[:pt_BR].count - 1) do |index|
  I18n.locale = 'pt-BR'
  profile = Profile.new
  profile.name = profiles[:pt_BR][index][:name]
  profile.has_theme = profiles[:pt_BR][index][:has_theme]

  I18n.locale = :en
  profile.name = profiles[:en][index][:name]

  I18n.locale = :es
  profile.name = profiles[:es][index][:name]

  profile.save
end

I18n.locale = 'pt-BR'

admin_user = User.create(email: 'admin@mail.com', password: '123456', full_name: 'Administrador do Sistema', user_name: 'admin')
luiz_user = User.create(email: 'luiz@mail.com', password: '123456', full_name: 'Luiz Sanches', user_name: 'luiz')

category = Category.first

vaam_template = admin_user.templates.create(name: 'VAAM 2009', font_color: '000000', image: File.open(File.join(Rails.root, 'app/assets/images/vaam_template.jpg')))
mare_template = admin_user.templates.create(name: 'Maré 2009', font_color: 'FFFFFF', image: File.open(File.join(Rails.root, 'app/assets/images/mare_template.jpg')))

vaam_certificate = admin_user.certificates.create(template: vaam_template, category: category, title: 'Visão Ágil Academic Leaders 2009', initial_date: '2009-05-19', final_date: '2009-05-19', workload: '8', local: 'auditório do IESAM, Belém - Pará')
mare_certificate = admin_user.certificates.create(template: mare_template, category: category, title: 'Maré de Agilidade Belém 2009', initial_date: '2009-11-19', final_date: '2009-11-19', workload: '8', local: 'auditório do CESUPA, Belém - Pará')

participant = Profile.find_by(name: 'participante')
speaker = Profile.find_by(name: 'palestrante')
organizer = Profile.find_by(name: 'organizador')

luiz_user.subscribers.create(certificate: vaam_certificate, profile: speaker, theme: 'Slackware Linux')
luiz_user.subscribers.create(certificate: mare_certificate, profile: participant)

admin_user.subscribers.create(certificate: mare_certificate, profile: organizer)
