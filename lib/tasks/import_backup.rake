require 'csv'
require 'net/https'

=begin

rails db:drop db:create db:seed
rails db:certifico:import_backup

rails db:mongoid:remove_indexes
rails db:mongoid:create_indexes

=end

namespace :db do
  namespace :certifico do
    desc 'Import backup in .csv files'
    task :import_backup => :environment do
      ImportBackup.run
    end
  end
end

class ImportBackup
  ASSET_PATH = "#{Rails.root}/tmp/import"
  SEPARATOR = '#'

  def self.download_asset(path, name)
    url = ENV['IMPORT_ASSETS_URL']

    image_file = name
    image_path = "/assets/import/#{path}/#{image_file}"
    image_dest = "#{ASSET_PATH}/#{path}/#{image_file}"

    unless File.exists?(image_dest)
      Net::HTTP.start(url) do |http|
        resp = http.get(image_path)

        open(image_dest, 'wb') do |file|
          file.write(resp.body)
        end
      end
    end
  end

  def self.create_dirs
    dirs = [ "#{ASSET_PATH}", "#{ASSET_PATH}/data", "#{ASSET_PATH}/logos", "#{ASSET_PATH}/templates" ]

    dirs.each do |dir|
      Dir.mkdir(dir) unless File.exists?(dir)
    end
  end

  def self.run
    if ENV['IMPORT_ASSETS_URL'].blank?
      puts "Error: import assets url not set."
      return
    end

    create_dirs

    download_asset('data', 'events.csv')

    CSV.foreach("#{ASSET_PATH}/data/events.csv", headers: true, col_sep: ';') do |event|
      id = event['id']
      name = event['nome'].strip
      type = event['tipo']
      text_color = event['cor_texto']
      site = event['site']
      email = event['email'].strip
      start_date = event['data_inicio']
      period = event['periodo']
      local = event['local']
      workload = event['carga_horaria']
      logo_file = event['arquivo_logo']
      certificate_file = event['arquivo_certificado'].gsub('.pdf', '.png')

      puts "> Event: #{name}"

      download_asset('templates', certificate_file)

      download_asset('logos', logo_file)

      site = site.gsub('palestrascoletivas.com.br', 'palestrascoletivas.tasafo.org')

      site = site.gsub('tasafo.wordpress.com', 'tasafo.org')

      font_color = case text_color
        when 'branco' then '#FFFFFF'
        when 'preto' then '#000000'
      end

      type_name = type.split.last
      type_name = 'evento' if type_name == 'do'

      I18n.locale = 'pt-BR'
      category = Category.find_by(name: type_name)

      final_date = start_date
      final_date = final_date[0..7] << period.split[3] if period.include?('dias')

      user = User.find_by(email: email)

      user = User.create(
        email: email,
        password: rand(11111111..99999999),
        full_name: email.split('@')[0],
        user_name: email.split('@')[0]
      ) unless user

      template = user.templates.create(
        name: name,
        font_color: font_color,
        image: File.new("#{ASSET_PATH}/templates/#{certificate_file}")
      )

      certificate = user.certificates.create(
        template: template,
        category: category,
        title: "#{id}#{SEPARATOR}#{name}",
        initial_date: start_date,
        final_date: final_date,
        workload: workload,
        local: local,
        site: site,
        image: File.new("#{ASSET_PATH}/logos/#{logo_file}")
      )
    end

    participant = Profile.find_by(name: 'participante')

    download_asset('data', 'individuals.csv')

    CSV.foreach("#{ASSET_PATH}/data/individuals.csv", headers: true, col_sep: ';') do |individual|
      name = format_name(individual['nome'])
      email = individual['email'].strip
      event_id = individual['id_evento']

      puts "> Individual: #{name}"

      username = format_username(name)

      user = User.find_by(email: email)

      user = User.create(
        email: email,
        password: rand(11111111..99999999),
        full_name: name,
        user_name: username
      ) unless user

      certificate = find_certificate_by(event_id)

      certificate.subscribers.create(user: user, profile: participant) if certificate
    end

    speaker = Profile.find_by(name: 'palestrante')
    organizer = Profile.find_by(name: 'organizador')

    download_asset('data', 'users.csv')

    CSV.foreach("#{ASSET_PATH}/data/users.csv", headers: true, col_sep: ';') do |user|
      name = format_name(user['nome'])
      email = user['email'].strip
      profiles = user['perfis'].split(',')
      theme = user['tema_palestra']
      event_id = user['id_evento']

      puts "> User: #{name}"

      username = format_username(name)

      theme = nil if theme.blank?

      user = User.find_by(email: email)

      user = User.create(
        email: email,
        password: rand(11111111..99999999),
        full_name: name,
        user_name: username
      ) unless user

      certificate = find_certificate_by(event_id)

      if certificate
        profiles.each do |profile|
          profile_select = case profile.strip
            when 'organizador' then organizer
            when 'palestrante' then speaker
            else nil
          end

          certificate.subscribers.create(
            user: user,
            profile: profile_select,
            theme: theme
          ) if certificate and profile_select
        end
      end
    end

    Certificate.all.each do |certificate|
      array = certificate.title.split(SEPARATOR)

      certificate.update(title: array[1]) if array.size > 1
    end
  end

  def self.format_name(name)
    no_cap = %w(e da de do das dos)

    name.downcase.split(' ').map { |word| no_cap.include?(word) ? word : word.capitalize }.join(' ')
  end

  def self.format_username(name)
    first_name = name.split.first
    last_name = name.split.last

    result = first_name
    result << " #{last_name}" if first_name != last_name

    result
  end

  def self.find_certificate_by(event_id)
    Certificate.find_by(title: /^#{event_id}#{SEPARATOR}/)
  end
end
