RSpec.describe OscnScraper::Parsers::CountsKp do
  describe '#parse' do
    it 'parses a count for a kp case' do
      fixture_path = 'spec/fixtures/parsers/counts/kp_small_counties.html'
      html_doc = load_and_parse_fixture(fixture_path)
      data = described_class.parse(html_doc)

      expect(data[:counts].count).to eq 3
      expect(data[:counts].first[:charge]).to eq 'DUI (FELONY)'
    end
  end
end
