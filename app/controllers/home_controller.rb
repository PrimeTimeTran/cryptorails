class HomeController < ApplicationController
  skip_before_action :authorize_request, only: :index

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
