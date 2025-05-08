module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class CountsKp
      include OscnScraper::Parsers::Helpers
      attr_reader :counts_html

      def initialize(counts_html)
        @counts_html = counts_html
        @counts = { counts: [] }
      end

      def self.parse(counts_html)
        new(counts_html).parse
      end

      def parse
        parse_counts
      end

      private

      def parse_counts
        counts = counts_html.css('p').map do |row|
          count_object(row)
        end
        { counts: counts }
      end

      def count_object(row)
        {
          number: count_number(row),
          charge: charge(row)
        }
      end

      def count_number(row)
        row.css('strong')[0].text.gsub('.', '')&.squish
      end

      def charge(row)
        row.xpath('./strong[1]/following-sibling::text()[1]').text&.squish
      end
    end
  end
end
