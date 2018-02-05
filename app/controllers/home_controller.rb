# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authorize_request, only: [:index, :show]

  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index
    prices = Price.recent_prices
    json_response(prices, :ok)
  end

  def show
    prices = Price.recent_prices(params[:id].to_i, 1)
    json_response(prices, :ok)
  end

  private

  def search_params
    params.slice(:coin_id, :time, :exchange)
  end
end
