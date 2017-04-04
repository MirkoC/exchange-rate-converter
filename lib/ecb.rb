class ECB
  def self.save_exchange_rate_data
    data_line_pattern = /\d{4}-\d{2}-\d{2},/
    new_records_count = 0

    string_data.each_line do |line|
      next unless line =~ data_line_pattern
      dissected = line.split(',')
      date = dissected[0]
      rate = dissected[1].to_d
      er = ExchangeRate.find_by_date(date)

      next if er

      er = ExchangeRate.new(date: date, rate: rate)
      if er.save
        new_records_count += 1
      else
        p '------------------------------'
        p "Record on a date #{date}, with rate #{rate} could not be saved!"
        p er.errors.full_messages
        p '------------------------------'
      end
    end

    p "#{new_records_count} new records saved!"
  end

  def self.string_data(url = nil)
    open_url = url || 'http://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
    raise TypeError, '<url> must be a string!' unless open_url.is_a? String
    open(open_url, &:read)
  end
end
