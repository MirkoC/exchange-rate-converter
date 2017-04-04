require 'rails_helper'

RSpec.describe ECB do
  describe :save_exchange_rate_data do
    it 'saves the exchange rate data to a string' do
      ECB.stub(:string_data) { File.open('spec/lib/data.csv', 'rb').read }
      expect(ExchangeRate.count).to eq(0)
      ECB.save_exchange_rate_data
      expect(ExchangeRate.count).to eq(ECB.string_data.lines.count - 5)
    end
  end
end
