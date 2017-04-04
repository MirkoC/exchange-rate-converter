class ExchangeRateConverter
  class ConversionImpossible < StandardError; end

  def self.convert(amount, date)
    raise TypeError, '<amount> must be numeric!' unless amount.is_a? Numeric
    raise TypeError, '<date> must be a string!' unless date.is_a? String

    er = ExchangeRate.find_closest_by_date(date)
    raise ConversionImpossible, 'Cannot exchange for requested date!!' unless er

    er.rate * amount
  end
end
