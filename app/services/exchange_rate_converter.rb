class ExchangeRateConverter
  class ConversionImpossible < StandardError; end

  def self.convert(amount, date)
    raise TypeError, '<amount> must be numeric!' unless amount.is_a? Numeric

    er = ExchangeRate.find_closest_by_date(date)
    raise ConversionImpossible, 'Cannot exchange for requested date!!' unless er

    amount/er.rate.to_f
  end
end
