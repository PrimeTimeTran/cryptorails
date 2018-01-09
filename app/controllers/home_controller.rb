class HomeController < ApplicationController
  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index
    @markets = Market.all
    respond_to do |format|
      format.json { render json: @markets }
      format.html
    end
  end
end
