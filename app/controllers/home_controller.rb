class HomeController < ApplicationController
  def index
  end

  def convert
    @converted_value = "#{ExchangeRateConverter.convert(*conversion_params).round(2)} €"
  rescue ExchangeRateConverter::ConversionImpossible => e
    @converted_value = e.message
  rescue ArgumentError => e
    @converted_value = e.message
  end

  private

  def conversion_params
    [
      params[:exchange_rate][:amount].to_d,
      params[:exchange_rate][:date]
    ]
  end
end
