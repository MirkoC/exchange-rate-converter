class ExchangeRate < ApplicationRecord
  validates :rate, :date, presence: true

  def self.find_closest_by_date(date)
    raise ArgumentError, 'invalid date format' unless date.is_a?(String) || date.is_a?(Date)
    true_date = date.to_date
    rec = ExchangeRate.find_by_date(true_date)
    return rec if rec
    ExchangeRate.where('date < ?', true_date).order('date DESC').first
  end
end
