class UrlShortener
  attr_reader :saved_urls
  def initialize
    @saved_urls = {}
  end

  def create_new(url)
    surl = extract_short(url)
    @saved_urls[surl] = verify(url)
    return surl
  end

  private

  def extract_short(url)
    return url.sub('http://', '').split('.').select { |u|
      u.length > 3
    }.join.tr('aeiou', '')[0..2] + short_url_nums
  end

  def short_url_nums
    return Array.new(3) { rand(9).to_s }.join
  end

  def verify(url)
    return url.include?('http') ? url : 'http://' + url
  end
end
