class HomeController < ApplicationController
  def index
    @certificates = Certificate.not_in(image: nil, site: "").desc(:initial_date)
  end
end
