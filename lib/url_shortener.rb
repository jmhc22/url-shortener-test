class UrlShortener
  attr_reader :saved_urls
  def initialize
    @saved_urls = {}
  end

  def create_new(url)
    surl = extract_short(url)
    url = 'http://' + url if !url.include? 'http'
    @saved_urls[surl] = url
    return surl
  end

  private

  def extract_short(url)
    url.sub('http://', '').split('.').select {
      |u| u.length > 3
    }.join.tr('aeiou', '')[0..2] + short_url_nums
  end

  def short_url_nums
    Array.new(3) { rand(9).to_s }.join
  end
end
