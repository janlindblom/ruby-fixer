require 'time'

module FixerIo
  module Response
    # Latest Rates response.
    class LatestRates
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

      # Create a new instance.
      #
      # @param [Hash] args arguments used to create the object.
      # @option args [Integer] :timestamp the exact date and time the given
      #   rates were collected.
      # @option args [String] :base the three-letter currency code of the base
      #   currency used for this request.
      # @option args [Hash] :rates exchange rate data for the currencies.
      def initialize(args)
        @timestamp = Time.at args[:timestamp].to_i
        @base = args[:base].downcase.to_sym
        @rates = Response.symbolize_hash_keys args[:rates]
      end
    end
  end
end
