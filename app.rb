require 'sinatra/base'
require './lib/url_shortener'

class UrlShortenerApp < Sinatra::Base

  before do
    @shortener = UrlShortener.instance
  end

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  get '/api/urls-list' do
    data = @shortener.saved_urls.map { |su, u| { short: su, url: u} }
    { urlList: data }.to_json
  end

  get '/:short_url' do
    redirect "#{@shortener.saved_urls[params[:short_url]]}", 301
  end

  post '/' do
    url = JSON.parse(request.body.read)
    short_url = @shortener.create_new(url['url'])
    { short_url: "/#{short_url}", url: @shortener.saved_urls[short_url] }.to_json
  end

  run! if app_file == $0
end
