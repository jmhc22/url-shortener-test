class UrlShortener
  attr_reader :saved_urls
  def initialize
    @saved_urls = {}
  end

  def create_new(url)
    short = extract_short(url)
    @saved_urls[short] = verify(url)
    return short
  end

  def self.instance
    @game ||= UrlShortener.new
    @game
  end

  private

  def extract_short(url)
    return remove_http(url).split('.').select { |url_component|
      url_component.length > 3
    }.join.tr('aeiou', '')[0..2] + short_url_nums
  end

  def short_url_nums
    return Array.new(3) { rand(9).to_s }.join
  end

  def verify(url)
    return url.include?('http') ? url : 'http://' + url
  end

  def remove_http(url)
    return url.sub('http://', '').sub('https://', '')
  end
end
