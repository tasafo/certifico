class FileImage
  def self.template(template, image_url, cloudinary_ready)
    return nil unless image_url

    rails_root = Rails.root

    return "#{rails_root}/public#{image_url}" unless cloudinary_ready

    template_path(rails_root, template.id, image_url)
  end

  def self.template_path(rails_root, template_id, image_url)
    directory = "#{rails_root}/tmp/templates"

    Dir.mkdir(directory) unless File.exist?(directory)

    template_file = "#{directory}/#{template_id}"

    download(image_url, template_file) unless File.exist?(template_file)

    template_file
  end

  def self.download(image_url, template_file)
    address = 'res.cloudinary.com'
    image_path = image_url.sub("http://#{address}", '')

    Net::HTTP.start(address) do |http|
      response = http.get(image_path)

      save(template_file, response.body)
    end
  end

  def self.save(template_file, content)
    File.open(template_file, 'wb') do |file|
      file.write(content)
    end
  end

  def self.remove(file)
    if CloudinaryReady.up?
      Cloudinary::Uploader.destroy(file.public_id)
    else
      file_path = file.path
      File.delete(file_path) if File.exist?(file_path)
    end
  end
end
