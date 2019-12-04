require 'url_shortener'

describe UrlShortener do

  describe '#create_new' do
    before :each do
      allow(subject).to receive(:rand).and_return(1)
    end

    it "returns short url 'frm111' when passed farmdrops url" do
      expect(subject.create_new('http://www.farmdrop.com')).to eq('frm111')
    end

    it "returns short url 'ggl222 when passed google's url" do
      expect(subject.create_new('http://www.google.com')).to eq('ggl111')
    end
  end
end
