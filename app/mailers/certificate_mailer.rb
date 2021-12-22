class CertificateMailer < ApplicationMailer
  def with_attachment
    @subscriber = Subscriber.find(params[:subscriber_id])
    @user = @subscriber.user
    certificate = @subscriber.certificate
    user_name = @user.full_name.parameterize
    certificate_title = certificate.title
    certificate_category = certificate.category
    profile_name = @subscriber.profile.name

    file_name = "certifico_#{user_name}_#{certificate_title.parameterize}_"\
                "#{profile_name.parameterize}.pdf"
    pdf_file = Rails.root.join('tmp', 'certificates', file_name).to_path

    @subscriber.create_certificate(pdf_file)

    attachments[pdf_file.split(File::SEPARATOR).last] = File.read(pdf_file)

    File.delete(pdf_file) if File.exist?(pdf_file)

    subject = "#{t('mongoid.models.certificate')} "\
              "#{certificate_category.preposition} "\
              "#{certificate_category.name} #{certificate_title} "\
              "(#{profile_name})"

    mail(to: @user.email, subject: subject)
  end
end
