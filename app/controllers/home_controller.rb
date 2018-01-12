class HomeController < ApplicationController
  skip_before_action :authorize_request, only: :index

  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index
    binding.pry
    prices = Price.five_minute_prices
    json_response(prices, :created)
  end

  private

  def search_params
    params.slice(:coin_id, :time, :exchange)
  end
end
