categories = {
  pt_BR: [
    { name: 'Evento', preposition: 'do' },
    { name: 'Encontro', preposition: 'do' },
    { name: 'Simpósio', preposition: 'do' },
    { name: 'Seminário', preposition: 'do' },
    { name: 'Congresso', preposition: 'do' },
    { name: 'Fórum', preposition: 'do' },
    { name: 'Curso', preposition: 'do' },
    { name: 'Conferência', preposition: 'da' },
    { name: 'Semana', preposition: 'da' },
    { name: 'Feira', preposition: 'da' },
    { name: 'Oficina', preposition: 'da' }
  ],
  en: [
    { name: 'Event', preposition: 'the' },
    { name: 'Meeting', preposition: 'the' },
    { name: 'Symposium', preposition: 'the' },
    { name: 'Seminar', preposition: 'the' },
    { name: 'Congress', preposition: 'the' },
    { name: 'Forum', preposition: 'the' },
    { name: 'Course', preposition: 'the' },
    { name: 'Conference', preposition: 'the' },
    { name: 'Week', preposition: 'the' },
    { name: 'Fair', preposition: 'the' },
    { name: 'Workshop', preposition: 'the' }
  ],
  es: [
    { name: 'Evento', preposition: 'en el' },
    { name: 'Reunión', preposition: 'en el' },
    { name: 'Simposio', preposition: 'en el' },
    { name: 'Seminario', preposition: 'en el' },
    { name: 'Congreso', preposition: 'en el' },
    { name: 'Foro', preposition: 'en el' },
    { name: 'Curso', preposition: 'en el' },
    { name: 'Conferencia', preposition: 'a la' },
    { name: 'Semana', preposition: 'a la' },
    { name: 'Feria', preposition: 'a la' },
    { name: 'Taller', preposition: 'a la' }
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
    { name: 'organização', has_theme: false },
    { name: 'palestrante', has_theme: true },
    { name: 'participante', has_theme: false },
    { name: 'congressista', has_theme: false },
    { name: 'coordenação', has_theme: true },
    { name: 'tutoria', has_theme: false },
    { name: 'docente', has_theme: false },
    { name: 'voluntariado', has_theme: false },
    { name: 'mediação', has_theme: false }
  ],
  en: [
    { name: 'organization' },
    { name: 'speaker' },
    { name: 'participant' },
    { name: 'congressman' },
    { name: 'coordination' },
    { name: 'tutoring' },
    { name: 'teacher' },
    { name: 'volunteering' },
    { name: 'mediation' }
  ],
  es: [
    { name: 'organización' },
    { name: 'orador' },
    { name: 'partícipe' },
    { name: 'congresista' },
    { name: 'coordinación' },
    { name: 'tutoría' },
    { name: 'profesorado' },
    { name: 'voluntariado' },
    { name: 'mediación' }
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

if Rails.env.development?
  I18n.locale = 'pt-BR'

  admin_user = User.create(
    email: 'admin@mail.com',
    password: '123456',
    full_name: 'Administrador do Sistema',
    user_name: 'admin',
    admin: true
  )

  luiz_user = User.create(
    email: 'luiz@mail.com',
    password: '123456',
    full_name: 'Luiz Sanches',
    user_name: 'luiz'
  )

  category = Category.first

  vaam_template = admin_user.templates.create(
    name: 'VAAM 2009',
    font_color: '#000000',
    image: File.new('spec/support/assets/images/vaam_template.jpg')
  )

  mare_template = admin_user.templates.create(
    name: 'Maré 2009',
    font_color: '#000000'
  )

  vaam_certificate = admin_user.certificates.create(
    template: vaam_template,
    category: category,
    title: 'Visão Ágil Academic Meeting 2009',
    initial_date: '2009-05-19',
    final_date: '2009-05-19',
    workload: '8',
    local: 'auditório do IESAM, Belém - Pará',
    image: File.new('spec/support/assets/images/vaam_template.jpg')
  )

  mare_certificate = admin_user.certificates.create(
    template: mare_template,
    category: category,
    title: 'Maré de Agilidade Belém 2009',
    initial_date: '2009-11-19',
    final_date: '2009-11-19',
    workload: '8',
    local: 'auditório do CESUPA, Belém - Pará'
  )

  participant = Profile.find_by(name: 'participante')
  speaker = Profile.find_by(name: 'palestrante')
  organizer = Profile.find_by(name: 'organização')

  luiz_user.subscribers.create(certificate: vaam_certificate,
                               profile: organizer)
  luiz_user.subscribers.create(certificate: vaam_certificate,
                               profile: speaker, theme: 'Slackware Linux')
  luiz_user.subscribers.create(certificate: mare_certificate,
                               profile: participant)
end
