class GenerateCertificate
  attr_accessor :subscriber, :certificate, :link

  PDF_OPTIONS = {
    page_size:   "A4",
    page_layout: :landscape,
    margin:      [40, 75]
  }

  def initialize(subscriber)
    @subscriber = subscriber
    @certificate = subscriber.certificate
    @link = "#{ENV['RETURN_URL']}/validates/#{@subscriber.id}"
    image = ImageCertificate.new(certificate).download
    PDF_OPTIONS[:background] = image unless image.nil?
  end

  def save
    pdf.render
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.fill_color certificate.template.font_color.gsub('#', '')

      pdf.move_down 200
      pdf.text "<font size='20'>#{certificate_body}</font>", inline_format: true, align: :justify

      pdf.bounding_box([pdf.bounds.right - 60, pdf.bounds.bottom - 30], width: 250, height: 20, align: :right) do
        pdf.text "<font size='10'><link href='#{@link}'>#{@subscriber.id}</link></font>", inline_format: true
      end
    end
  end

  def certificate_body
    text =  "#{I18n.t('title.certificate.certify_that')} <b>#{subscriber.user.full_name}</b> "
    text << "#{I18n.t('title.certificate.attended')} #{certificate.category.preposition} #{certificate.category.name} #{certificate.title}, "
    text << "#{I18n.t('title.certificate.realized')} #{certificate_long_date}, #{certificate.local}, #{certificate_work_load}, "
    text << "#{I18n.t('title.certificate.quality_of')} <b>#{subscriber.profile.name}</b>#{certificate_theme}"
    text
  end

  def certificate_long_date
    date1 = certificate.initial_date
    date2 = certificate.final_date

    date_between = I18n.t('title.certificate.date.between')
    date_and = I18n.t('title.certificate.date.and')
    date_of = I18n.t('title.certificate.date.of')
    date_format = "%B #{date_of} %Y"

    if date1 == date2
      "#{I18n.t('title.certificate.date.on')} #{I18n.l date1, format: :long}"
    elsif date1.year != date2.year
      "#{date_between} #{I18n.l date1, format: :long} #{date_and} #{I18n.l date2, format: :long}"
    elsif date1.month == date2.month
      "#{date_between} #{date1.day} #{date_and} #{date2.day} #{date_of} #{I18n.l date1, format: date_format}"
    else
      "#{date_between} #{date1.day} #{date_of} #{I18n.l date1, format: '%B'} #{date_and} #{date2.day} #{date_of} #{I18n.l date2, format: date_format}"
    end
  end

  def certificate_work_load
    "#{I18n.t('title.certificate.with_hours')} #{certificate.workload} #{I18n.t('title.certificate.workload.hour').pluralize(certificate.workload.to_i)}"
  end

  def certificate_theme
    if subscriber.profile.has_theme? && !subscriber.theme.empty?
      " #{I18n.t('title.certificate.theme')} \"#{subscriber.theme}\"."
    else
      '.'
    end
  end
end
