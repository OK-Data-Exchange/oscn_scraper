require 'byebug'
module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Parties
      attr_reader :parties_html

      def initialize(parties_html)
        @parties_html = parties_html
        @parties = { parties: [] }
      end

      def self.parse(parties_html)
        new(parties_html).parse
      end

      def parse
        parse_parties
      end

      private

      attr_accessor :parties

      def parse_parties
        return parties if parties_html.blank?

        if parties_html.css('a').empty?
          parties_html.css('p').children.each do |element|
            build_parties_text(element) unless element.text.blank?
          end
        else
          parties_html.css('a').each do |link|
            build_parties(link)
          end
        end
        parties
      end

      def build_parties(link)
        parties[:parties] << {
          name: link.text.strip,
          link: link.attributes['href'].value,
          party_type: link.xpath('following-sibling::span[@class="parties_type"]').first.text.gsub(',', '').squish
        }
      end

      def build_parties_text(element)
        parts = element.text.split(",\r\n")
        parties[:parties] << {
          name: parts[0]&.strip,
          party_type: parts[1]&.strip
        }
      end
    end
  end
end
