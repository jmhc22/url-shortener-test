class UrlShortener
  attr_reader :saved_urls
  def initialize
    @saved_urls = {}
  end

  def create_new(url)
    surl = url.split('.')[1].tr('aeiou', '')[0..2] + Array.new(3) { rand(9).to_s }.join
    @saved_urls[surl] = url
    return surl
  end
end
