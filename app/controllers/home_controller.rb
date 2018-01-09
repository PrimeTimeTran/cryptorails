require 'coinbase/wallet'
require 'em-http'

class HomeController < ApplicationController
  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index

  end
end
