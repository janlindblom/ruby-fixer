module FixerIo
  # Holds configuration of the module required for it to work.
  class Configuration
    # Sets the fixer.io API key.
    # @return [String]
    attr_accessor :api_key

    # API Endpoint.
    # @return [String]
    API_ENDPOINT = 'http://data.fixer.io/api/'.freeze

    def initialize
      @api_key = ''
    end
  end
end
