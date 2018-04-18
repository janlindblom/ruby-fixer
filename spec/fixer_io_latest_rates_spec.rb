RSpec.describe FixerIo do
  describe '#latest_rates' do
    context 'with only a free account' do
      before :all do
        FixerIo.configure do |config|
          config.api_key = ENV.fetch 'FIXER_IO_API_KEY'
        end
      end

      it 'will not allow you to change the base currency' do
        expect do
          FixerIo.latest_rates base: 'SEK'
        end.to raise_error FixerIo::BaseCurrencyAccessRestrictedError
      end
    end
    context 'with a valid API key' do
      before :all do
        FixerIo.configure do |config|
          config.api_key = ENV.fetch 'FIXER_IO_API_KEY'
        end
      end

      it 'can return the latest rates for all available currencies' do
        response = FixerIo.latest_rates
        expect(response).to be_a FixerIo::Response::LatestRates
        expect(response.rates).not_to be_empty
        expect(response.rates).to have_key response.base
      end

      it 'can return the latest rates for only selected currencies' do
        response = FixerIo.latest_rates symbols: 'SEK,USD,GBP'
        expect(response).to be_a FixerIo::Response::LatestRates
        expect(response.rates).not_to be_empty
        expect(response.rates.size).to eq 3
        %i[sek usd gbp].each do |cur|
          expect(response.rates).to have_key cur
        end
      end
    end

    context 'with an invalid API key' do
      before :all do
        FixerIo.configure do |config|
          config.api_key = 'BADKEY'
        end
      end

      it 'will raise an InvalidApiKeyError' do
        expect do
          FixerIo.latest_rates
        end.to raise_error FixerIo::InvalidApiKeyError
      end
    end

    context 'without an API key' do
      before :all do
        FixerIo.configure do |config|
          config.api_key = nil
        end
      end

      it 'will raise a MissingApiKeyError' do
        expect { FixerIo.latest_rates }.to raise_error FixerIo::MissingApiKeyError
      end
    end
  end
end
