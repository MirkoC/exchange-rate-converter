require 'rails_helper'

RSpec.describe ExchangeRateConvert do
  describe :convert do
    let!(:stubbed_data) { ECB.stub(:string_data) { File.open('spec/lib/data.csv', 'rb').read } }
    let!(:saved_data) { ECB.save_exchange_rate_data }
    it 'converts dolars to euros' do
      er = ExchangeRate.second
      converted_value = ExchangeRateConverter.convert(120, er.date)
      expect(converted_value).to eq(er.rate * 120)
    end

    it 'cannot convert non numeric amounts' do
      expect { ExchangeRateConverter.convert('abcdefg', '2000-01-01') }.to raise_exception(TypeError)
    end

    it 'cannot convert for too old dates' do
      testing_date = '1800-05-05'
      expect { ExchangeRateConverter.convert(120, testing_date) }.to raise_exception(ExchangeRateConverter::ConversionImpossible)
    end
  end
end
