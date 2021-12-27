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
  records = 20
  I18n.locale = 'pt-BR'
  Faker::Config.locale = I18n.locale

  category = Category.first
  participant = Profile.find_by(name: 'participante')
  speaker = Profile.find_by(name: 'palestrante')
  organizer = Profile.find_by(name: 'organização')

  admin_user = User.create(
    email: 'admin@mail.com',
    password: '123456',
    full_name: 'Administrador do Sistema',
    user_name: 'admin',
    admin: true
  )

  mare_template = admin_user.templates.create(
    name: 'VAAM', font_color: '#000000',
    image: File.new(ImageFile.dummy('templates', 'vaam.jpg'))
  )

  admin_user.certificates.create(
    template: mare_template, category: category,
    title: 'VAAM 2009',
    initial_date: Date.today, final_date: Date.today, workload: '8',
    local: 'auditório do IESAM, Belém - Pará',
    image: File.new(ImageFile.dummy('certificates', 'vaam.jpg'))
  )

  1.upto(records) do
    name = Faker::Name.name
    user_name = "#{name.split.first.parameterize}.#{name.split.last.parameterize}"

    User.create(email: "#{user_name}@mail.com", password: '123456',
                full_name: name, user_name: user_name)
  end

  1.upto(records) do
    name = Faker::ProgrammingLanguage.name

    template = admin_user.templates.create(
      name: name, font_color: '#000000',
      image: File.new(ImageFile.dummy('templates', 'mare-de-agilidade.jpg'))
    )

    certificate = admin_user.certificates.create(
      template: template, category: category,
      title: "#{name} #{Date.today.year}",
      initial_date: Date.today, final_date: Date.today, workload: '8',
      local: 'auditório do CESUPA, Belém - Pará',
      image: File.new(ImageFile.dummy('certificates', 'mare-de-agilidade.jpg'))
    )

    User.all.each do |user|
      user.subscribers.create(certificate: certificate, profile: organizer)
      user.subscribers.create(certificate: certificate, profile: speaker,
                              theme: Faker::Computer.os)
      user.subscribers.create(certificate: certificate, profile: participant)
    end
  end
end
