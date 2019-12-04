class UrlShortener
  attr_reader :saved_urls
  def initialize
    @saved_urls = {}
  end

  def create_new(url)
    surl = extract_short(url)
    @saved_urls[surl] = url
    return surl
  end

  private

  def extract_short(url)
    url.split('.')[1].tr('aeiou', '')[0..2] + short_url_nums
  end

  def short_url_nums
    Array.new(3) { rand(9).to_s }.join
  end
end
