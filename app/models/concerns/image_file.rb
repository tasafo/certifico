class ImageFile
  def self.template(template, image_url)
    return nil unless image_url

    rails_root = Rails.root

    if CloudinaryReady.up?
      template_path(rails_root, template.id, image_url)
    else
      "#{rails_root.join('public').to_path}#{image_url}"
    end
  end

  def self.template_path(rails_root, template_id, image_url)
    directory = rails_root.join('tmp', 'templates').to_path

    Dir.mkdir(directory) unless File.exist?(directory)

    template_file = "#{directory}#{File::SEPARATOR}#{template_id}"

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

  def self.dummy_template
    Rails.root.join('spec', 'support', 'assets', 'images', 'vaam_template.jpg')
  end
end
