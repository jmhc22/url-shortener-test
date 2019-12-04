require 'sinatra/base'
require './lib/url_shortener'

class UrlShortenerApp < Sinatra::Base

  before do
    @url_s = UrlShortener.instance
  end

  run! if app_file == $0
end
