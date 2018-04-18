module FixerIo
  # Base Currency Access Restricted Error.
  #
  # This occurs whenever a request contains a +:base+ option and the API key
  # is on the wrong access tier.
  class BaseCurrencyAccessRestrictedError < StandardError
  end
end
