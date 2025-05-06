# rubocop:disable Metrics/BlockLength
RSpec.describe OscnScraper::Parsers::CountsKp do
  describe '#parse' do
    it 'parses a count for a kp case' do
      fixture_path = 'spec/fixtures/parsers/counts/kp_small_counties.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('.CountsContainer')
      data = described_class.parse(parsed_html)

      expect(data[:counts].count).to eq 1
      expect(data[:counts].first[:disposition]).to eq 'CONVICTION, 01/14/2020. Guilty Plea'
      expect(data[:counts].first[:filed_statute_code]).to eq 'BRG2'
    end
  end
end
# rubocop:enable Metrics/BlockLength
