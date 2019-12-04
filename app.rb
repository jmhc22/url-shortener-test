require 'sinatra/base'

class UrlShortenerApp < Sinatra::Base

  run! if app_file == $0
end
