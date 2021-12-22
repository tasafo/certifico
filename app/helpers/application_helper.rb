module ApplicationHelper
  def show_image(model, alt, size = '50x50')
    image_tag(https(model.image.url), alt: alt, size: size) if model.image?
  end

  def https(url)
    return '' unless url

    change = url[0, 2] == '//' ? '//' : 'http://'

    url.gsub(change, 'https://')
  end
end
