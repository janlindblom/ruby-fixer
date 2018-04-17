require "fixer_io/version"
require 'fixer_io/configuration'

# Interface to the fixer.io API.
#
# @author Jan Lindblom <janlindblom@fastmail.fm>
module FixerIo
  # Modify the current configuration.
  #
  # @example
  #   FixerIo.configure do |config|
  #     config.api_key = "YOUR_API_KEY"
  #   end
  #
  # @yieldparam [Configuration] config current configuration
  def self.configure
    self.configuration ||= RandomOrg::Configuration.new
    yield self.configuration
  end
end
