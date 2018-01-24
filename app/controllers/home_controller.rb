# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authorize_request, only: :index

  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index
    prices = Price.recent_prices
    json_response(prices, :ok)
  end

  private

  def search_params
    params.slice(:coin_id, :time, :exchange)
  end
end
