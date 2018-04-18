# FixerIo

![Amazon CodeBuild](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiUDl6UGFwN3A5dUZmdE5PTkJsNk5KQ0V6UXlCT2ZaWkJxMld0enBCVC92dGxEOC9iM1F2cEtNVW5ua0JaTGl0N0VobjNsbGI2WEZ3eEJaOFduV3BUSkdRPSIsIml2UGFyYW1ldGVyU3BlYyI6IkdhQXplZytUYWx6U0lrQkciLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)
[![Bitbucket Pipelines](https://img.shields.io/bitbucket/pipelines/janlindblom/ruby-fixer.png)](https://bitbucket.org/janlindblom/ruby-fixer/addon/pipelines/home)
[![Gem](https://img.shields.io/gem/v/fixer_io.png)](https://rubygems.org/gems/fixer_io)
[![Documentation](https://img.shields.io/badge/docs-rdoc.info-yellow.png)](http://www.rubydoc.info/gems/fixer_io/frames)

Interface to the fixer.io API. See [fixer.io](https://fixer.io/) for details on
getting an API key.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fixer_io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fixer_io

## Usage

Before using the library, you need to configure it with your API key. See
https://fixer.io/product for information on getting a key.

```ruby
FixerIo.configure do |config|
  config.api_key = "YOUR_API_KEY"
end
```

#### Latest Rates

```ruby
# Get the latest rates for all currencies like so:
FixerIo.latest_rates => #<FixerIo::Response::LatestRates:0x00007fd11c0d39d8
 @base=:eur,
 @rates=
  {:aed=>4.54192,
   :afn=>86.44557,
   :all=>128.678993,
   ...,
   :zmk=>11131.842267,
   :zmw=>11.724245,
   :zwl=>398.657538},
 @timestamp=2018-04-18 13:19:03 +0300>

# Get the latest rates for only a selected number of currencies like so:
FixerIo.latest_rates(symbols: 'SEK,USD,GBP') => #<FixerIo::Response::LatestRates:0x00007fd11ca46bf0
 @base=:eur,
 @rates={:sek=>10.405956, :usd=>1.236703, :gbp=>0.870949},
 @timestamp=2018-04-18 13:19:03 +0300>
```

#### Historical Rates

```ruby
# Get historical rates for all currencies like so:
FixerIo.historical_rates('2018-01-01') => #<FixerIo::Response::HistoricalRates:0x00007fd11d10eff0
 @base=:eur,
 @date=#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>,
 @historical=true,
 @rates=
  {:aed=>4.412975,
   :afn=>83.395841,
   :all=>132.765995,
   ...,
   :zmk=>10814.90303,
   :zmw=>11.979648,
   :zwl=>387.308253},
 @timestamp=2018-01-02 01:59:59 +0200>

# Get historical rates for only a selected number of currencies like so:
FixerIo.historical_rates('2018-01-01', symbols: 'SEK,USD,GBP') => #<FixerIo::Response::HistoricalRates:0x00007fd11c16b3c8
 @base=:eur,
 @date=#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>,
 @historical=true,
 @rates={:sek=>9.823708, :usd=>1.201496, :gbp=>0.889131},
 @timestamp=2018-01-02 01:59:59 +0200>
```

## Limitations

The first release of the gem will only work with the resources available to
free accounts on [fixer.io](https://fixer.io/).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on Bitbucket at
https://bitbucket.org/janlindblom/ruby-fixer. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FixerIo project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://bitbucket.org/janlindblom/ruby-fixer/src/master/CODE_OF_CONDUCT.md).
