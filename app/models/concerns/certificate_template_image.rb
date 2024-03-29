class CertificateTemplateImage
  attr_reader :certificate

  def initialize(certificate)
    @certificate = certificate
  end

  def pull
    template = @certificate.template

    ImageFile.template(template, template.image_url)
  end
end
