namespace :exchange_rate do
  task save_data: :environment do
    ECB.save_exchange_rate_data
  end
end
