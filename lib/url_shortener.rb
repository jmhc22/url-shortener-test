class UrlShortener

  def create_new(url)
    url.split('.')[1].tr('aeiou', '')[0..2] + Array.new(3) { rand(9).to_s }.join
  end
end
