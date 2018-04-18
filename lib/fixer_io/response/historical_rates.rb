require 'date'
require 'time'

module FixerIo
  module Response
    # Historical Rates response.
    class HistoricalRates
      # The exact date and time the given rates were collected.
      # @return [Time]
      attr_reader :timestamp

      # The three-letter currency code of the base currency used for this
      # request.
      # @return [Symbol]
      attr_reader :base

      # Exchange rate data for the currencies you have requested.
      # @return [Hash<Symbol, Numeric>]
      attr_reader :rates

      # Returns +true+ if a request for historical exchange rates was made.
      # @return [Boolean]
      attr_reader :historical

      # The date for which historical rates were requested.
      # @return [Date]
      attr_reader :date

      # Create a new instance.
      #
      # @param [Hash] args arguments used to create the object.
      # @option args [Integer] :timestamp the exact date and time the given
      #   rates were collected.
      # @option args [String] :base the three-letter currency code of the base
      #   currency used for this request.
      # @option args [Hash] :rates exchange rate data for the currencies.
      # @option args [Boolean] :historical +true+ if a request for historical
      #   exchange rates was made.
      # @option args [String] :date the date for which historical rates were
      #   requested.
      def initialize(args)
        @timestamp = Time.at args[:timestamp].to_i
        @base = args[:base].downcase.to_sym
        @rates = Response.symbolize_hash_keys args[:rates]
        @date = Date.parse args[:date]
        @historical = args[:historical]
      end
    end
  end
end
