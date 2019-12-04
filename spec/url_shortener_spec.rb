require 'url_shortener'

describe UrlShortener do
  describe '#create_short' do
    it "returns short url 'frm111' when passed farmdrops url" do
      allow(subject).to receive(:rand).and_return(1)
      expect(subject.create_short('http://www.farmdrop.com')).to eq('frm111')
    end
  end
end
