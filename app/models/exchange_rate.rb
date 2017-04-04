class ExchangeRate < ApplicationRecord
  validates :rate, :date, presence: true
end
