require 'fixer_io/response/latest_rates'
require 'fixer_io/response/historical_rates'

module FixerIo
  # API Responses.
  module Response
    class << self
      # Make String Hash keys into Symbols.
      #
      # @api private
      # @param [Hash<String, Object>] hash
      # @return [Hash<Symbol, Object>]
      def symbolize_hash_keys(hash)
        hash.keys.each do |key|
          hash[(begin
                  key.downcase.to_sym
                rescue StandardError
                  key
                end) || key] = hash.delete(key)
        end
        hash
      end
    end
  end
end
