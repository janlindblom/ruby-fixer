require 'json'
require 'rest-client'
require 'fixer_io/version'
require 'fixer_io/configuration'
require 'fixer_io/api_server_error'
require 'fixer_io/missing_api_key_error'
require 'fixer_io/invalid_api_key_error'
require 'fixer_io/base_currency_access_restricted_error'
require 'fixer_io/response'

# Interface to the fixer.io API.
#
# @author Jan Lindblom <janlindblom@fastmail.fm>
module FixerIo
  class << self
    # Module configuration.
    # @return [Configuration]
    attr_accessor :configuration

    private

    def query_api(request)
      perform_request(request[:function], request[:params])
    end

    def build_request(which_request, args = {})
      {
        function: which_request,
        params: args.merge(access_key: FixerIo.configuration.api_key)
      }
    end

    def perform_request(req, params)
      request = Configuration::API_ENDPOINT + req
      response = RestClient.get(request, params: params, accept: :json)
      case response.code
      when 200
        return process_response(response.body)
      when 500
        raise ApiServerError, 'A server-side error occured.'
      end
      nil
    end

    def process_response(body)
      parsed = JSON.parse(body)

      return parsed if parsed.key?('success') && parsed['success']

      handle_error(parsed['error']) unless parsed['success']
    end

    def handle_error(error)
      error_type = error['type'] if error.key? 'type'
      error_info = error['info'] if error.key? 'info'
      raise_errors(error_type, error_info)
    end

    def raise_errors(error_type, error_info)
      raise MissingApiKeyError, error_info if error_type == 'missing_access_key'
      if error_type == 'base_currency_access_restricted'
        raise BaseCurrencyAccessRestrictedError,
              'Base currency access is restricted for this API key.'
      end
      raise InvalidApiKeyError, error_info if error_type == 'invalid_access_key'
      raise StandardError,
            "#{error_type}: #{error_info ? error_info : 'Unknown error'}"
    end
  end

  # Modify the current configuration.
  #
  # @example Set your API key
  #   FixerIo.configure do |config|
  #     config.api_key = "YOUR_API_KEY"
  #   end
  #
  # @yieldparam [Configuration] config current configuration
  def self.configure
    self.configuration ||= Configuration.new
    yield self.configuration
  end

  # Get historical rates for a given date.
  #
  # @example Get historical rates for a given date and all currencies
  #   FixerIo.historical_rates '2018-01-01'
  #
  # @example Historical rates for a given date and selected currencies
  #   FixerIo.historical_rates '2018-01-01', symbols: 'SEK,USD,GBP'
  #
  # @param [String] date the date to fetch rates for.
  # @param [Hash] args optional arguments.
  # @option args [String] :base base currency.
  # @option args [String] :symbols comma separated list of currency symbols.
  # @return [Response::HistoricalRates] historical rates for the given date.
  def self.historical_rates(date, args = {})
    response = query_api(build_request(date, args))
    Response::HistoricalRates.new base: response['base'],
                                  rates: response['rates'],
                                  timestamp: response['timestamp'],
                                  historical: response['historical'],
                                  date: response['date']
  end

  # Get historical rates for a given date.
  #
  # Shorthand for {FixerIo#historical_rates}.
  #
  # @see FixerIo#historical_rates
  # @param [String] date the date to fetch rates for.
  # @param [Hash] args optional arguments.
  # @option args [String] :base base currency.
  # @option args [String] :symbols comma separated list of currency symbols.
  # @return [Response::HistoricalRates] historical rates for the given date.
  def self.historical(date, args = {})
    historical_rates(date, args)
  end

  # Get latest rates.
  #
  # @example Latest rates for all available currencies
  #   FixerIo.latest_rates
  #
  # @example Latest rates for selected currencies only
  #   FixerIo.latest_rates symbols: 'SEK,USD,GBP'
  #
  # @param [Hash] args optional arguments.
  # @option args [String] :base base currency.
  # @option args [String] :symbols comma separated list of currency symbols.
  # @return [Response::LatestRates] historical rates for the given date.
  def self.latest_rates(args = {})
    response = query_api(build_request('latest', args))
    Response::LatestRates.new timestamp: response['timestamp'],
                              base: response['base'],
                              rates: response['rates']
  end

  # Get latest rates.
  #
  # Shorthand for {FixerIo#latest_rates}.
  #
  # @see FixerIo#latest_rates
  # @param [Hash] args optional arguments.
  # @option args [String] :base base currency.
  # @option args [String] :symbols comma separated list of currency symbols.
  # @return [Response::LatestRates] historical rates for the given date.
  def self.latest(args = {})
    latest_rates(args)
  end
end
