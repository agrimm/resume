require 'formatted_text_entry'
require 'formatted_text_box_entry'

module ResumeGenerator
  class Header

    attr_reader :pdf, :data

    def self.generate(pdf, data)
      new(pdf, data).generate
    end

    def initialize(pdf, data)
      @pdf = pdf
      @data = data
      # Different rendering behaviour needed depending on whether the header is
      # being drawn from left to right on the page or specifically placed at
      # a location
      if data[:at]
        extend FormattedTextBoxEntry
      else
        extend FormattedTextEntry
      end
    end

    def generate
      position
      organisation
      period_and_location
    end

    private

    def formatted_entry_args_for(string, size)
      { text: string, styles: [:bold], size: size }
    end

    def period_and_location_args_for(period, location, location_link)
      [
        {
          text: period,
          color: data[:period_font_colour],
          size: data[:period_font_size]
        },
        {
          text: location,
          link: location_link,
          color: data[:location_font_colour],
          size: data[:location_font_size]
        }
      ]
    end
  end
end
