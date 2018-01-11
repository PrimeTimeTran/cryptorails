class HomeController < ApplicationController
  skip_before_action :authorize_request, only: :index

  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index
    @markets = Market.all
    json_response(@markets, :created)
  end
end
