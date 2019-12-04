require 'sinatra/base'
require './lib/url_shortener'

class UrlShortenerApp < Sinatra::Base

  before do
    @u_shortener = UrlShortener.instance
  end

  post '/' do
    url = JSON.parse(request.body.read)
    short_url = @u_shortener.create_new(url['url'])
    { short_url: "/#{short_url}", url: @u_shortener.saved_urls[short_url] }.to_json
  end

  run! if app_file == $0
end
