class CertificateMailer < ApplicationMailer
  def with_attachment
    @subscriber = Subscriber.find(params[:subscriber_id])
    @user = @subscriber.user
    certificate = @subscriber.certificate
    user_name = @user.full_name.parameterize
    certificate_title = certificate.title
    certificate_category = certificate.category
    profile_name = @subscriber.profile.name

    pdf_file = "#{Rails.root}/tmp/certifico_#{user_name}_"
    pdf_file << "#{certificate_title.parameterize}_#{profile_name.parameterize}"
    pdf_file << '.pdf'

    GenerateCertificate.new(@subscriber).render(pdf_file)

    attachments[pdf_file.split('/').last] = File.read(pdf_file)

    File.delete(pdf_file) if File.exist?(pdf_file)

    Download.create(subscriber: @subscriber)

    subject = "#{t('mongoid.models.certificate')} "
    subject << "#{certificate_category.preposition} "
    subject << "#{certificate_category.name} #{certificate_title} (#{profile_name})"

    mail(to: @user.email, subject: subject)
  end
end
