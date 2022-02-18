class CertificateGenerator
  attr_reader :subscriber, :certificate, :link

  def initialize(subscriber)
    @pdf_options = { page_size: 'A4', page_layout: :landscape, margin: [40, 75] }
    @subscriber = subscriber
    @certificate = subscriber.certificate
    @link = "#{ENV['VALIDATES_URL']}/validates/#{@subscriber.id}"
    template_image = @certificate.template_image
    @pdf_options[:background] = template_image if template_image
  end

  def save
    pdf.render
  end

  def render(file_name)
    pdf.render_file file_name
  end

  def pdf
    Prawn::Document.new(@pdf_options) do |pdf|
      pdf.fill_color certificate.template.font_color.delete('#')

      pdf.move_down 200
      pdf.text "<font size='20'>#{certificate_body}</font>", inline_format: true, align: :justify

      pdf.bounding_box([pdf.bounds.right - 60, pdf.bounds.bottom - 30], width: 250, height: 20, align: :right) do
        pdf.text "<font size='10'><link href='#{@link}'>#{@subscriber.id}</link></font>", inline_format: true
      end
    end
  end

  def certificate_body
    category = certificate.category

    "#{I18n.t('title.certificate.certify_that')} <b>#{subscriber.user.full_name}</b> #{I18n.t('title.certificate.attended')} #{category.preposition} #{category.name} #{certificate.title}, #{I18n.t('title.certificate.realized')} #{certificate_long_date}, #{certificate.local}, #{certificate_work_load}, #{I18n.t('title.certificate.quality_of')} <b>#{subscriber.profile.name}</b>#{certificate_theme}"
  end

  def certificate_long_date
    initial_date = certificate.initial_date
    final_date = certificate.final_date
    title_date_of = title_date('of')
    title_date_between = title_date('between')
    title_date_and = title_date('and')
    date_format = "%B #{title_date_of} %Y"

    if initial_date == final_date
      "#{title_date('on')} #{format_date(initial_date, :long)}"
    elsif initial_date.year != final_date.year
      "#{title_date_between} #{format_date(initial_date, :long)} #{title_date_and} #{format_date(final_date, :long)}"
    elsif initial_date.month == final_date.month
      "#{title_date_between} #{initial_date.day} #{title_date_and} #{final_date.day} #{title_date_of} #{format_date(initial_date, date_format)}"
    else
      "#{title_date_between} #{initial_date.day} #{title_date_of} #{format_date(initial_date, '%B')} #{title_date_and} #{final_date.day} #{title_date_of} #{format_date(final_date, date_format)}"
    end
  end

  def title_date(title)
    I18n.t("title.certificate.date.#{title}")
  end

  def format_date(date, format)
    I18n.l(date, format: format)
  end

  def certificate_work_load
    workload = certificate.workload

    "#{I18n.t('title.certificate.with_hours')} #{workload} #{I18n.t('title.certificate.workload.hour').pluralize(workload.to_i)}"
  end

  def certificate_theme
    theme = subscriber.theme

    if subscriber.profile.has_theme? && !theme.blank?
      " #{I18n.t('title.certificate.theme')} \"#{theme}\"."
    else
      '.'
    end
  end
end
