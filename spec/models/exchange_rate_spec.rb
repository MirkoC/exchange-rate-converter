require 'rails_helper'

RSpec.describe ExchangeRate do
  describe :find_closest_by_date do
    let!(:stubbed_data) { ECB.stub(:string_data) { File.open('spec/lib/data.csv', 'rb').read } }
    let!(:saved_data) { ECB.save_exchange_rate_data }

    it 'gets the exact or first closest record by date' do
      er = ExchangeRate.find_closest_by_date('2017-03-12')
      expect(er.date).to eq('2017-03-10'.to_date)
    end

    it 'raises Argument error if date is nor String nor Date type' do
      expect { ExchangeRate.find_closest_by_date(1234) }.to raise_exception(ArgumentError)
    end
  end
end
