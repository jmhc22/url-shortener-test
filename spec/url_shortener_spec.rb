require 'url_shortener'

describe UrlShortener do

  describe '#create_new' do
    before :each do
      allow(subject).to receive(:rand).and_return(1)
    end

    context "url fully formatted with both 'http://' and 'www.'" do
      it "returns short url 'frm111' when passed farmdrop's url" do
        expect(subject.create_new('http://www.farmdrop.com')).to eq('frm111')
      end

      it "returns short url 'ggl222 when passed google's url" do
        expect(subject.create_new('http://www.google.com')).to eq('ggl111')
      end

      it "saves created short url and full url as a key value pair in a hash variable" do
        short_url = subject.create_new('http://www.farmdrop.com')
        expect(subject.saved_urls[short_url]).to eq('http://www.farmdrop.com')
      end

      it "also accepts urls with 'https' rather than 'http'" do
        short_url = subject.create_new('https://www.farmdrop.com')
        expect(short_url).to eq('frm111')
        expect(subject.saved_urls[short_url]).to eq('https://www.farmdrop.com')
      end
    end

    context "url is missing either 'http://' and/or 'www.'" do
      it "returns short url 'frm111' when passed farmdrop's url without 'www.'" do
        expect(subject.create_new('http://farmdrop.com')).to eq('frm111')
      end

      it "returns short url 'ggl111' when passed google's url without 'www.'" do
        expect(subject.create_new('http://www.google.com')).to eq('ggl111')
      end

      it "adds 'http://' to the full url if missed off when passed as argument" do
        short_url = subject.create_new('www.farmdrop.com')
        expect(short_url).to eq('frm111')
        expect(subject.saved_urls[short_url]).to eq('http://www.farmdrop.com')
      end
    end
  end
end
