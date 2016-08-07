require 'net/http'

class ImageCertificate
  attr_accessor :certificate

  def initialize(certificate)
    @certificate = certificate
  end

  def download
    if Rails.env.test?
      image_file = File.join(Rails.root, 'app/assets/images/vaam_template.jpg')
    else
      url = certificate.template.image_url

      image_file = "#{Rails.root}/tmp/#{certificate.id}"

      image_path = url.sub("http://res.cloudinary.com", "")

      Net::HTTP.start( 'res.cloudinary.com' ) { |http|
        resp = http.get( image_path )
        open( image_file, 'wb' ) { |file|
          file.write(resp.body)
        }
      }

      image_file
    end
  end
end
