require 'net/http'

class ImageCertificate
  attr_accessor :certificate

  def initialize(certificate)
    @certificate = certificate
  end

  def get_image
    url = certificate.template.image_url

    return nil if url.nil?

    image_file = ENV['CLOUDINARY_URL'].nil? ? "#{Rails.root}/public/#{url}" : "#{Rails.root}/tmp/#{certificate.id}"

    download_image(url, image_file) unless ENV['CLOUDINARY_URL'].nil?

    image_file
  end

  private

  def download_image(url, image_file)
    address = 'res.cloudinary.com'

    image_path = url.sub("http://#{address}", "")

    Net::HTTP.start(address) do |http|
      resp = http.get(image_path)

      open(image_file, 'wb') do |file|
        file.write(resp.body)
      end
    end
  end
end
