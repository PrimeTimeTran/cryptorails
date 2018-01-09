require 'coinbase/wallet'
require 'em-http'

class HomeController < ApplicationController
  COINBASE = ['BTC-USD', 'ETH-USD']
  BITFINEX = ['btcusd', 'ethusd', 'etcusd']

  def index
    @markets = {coinbase: {}, bitfinex: {}}
    COINBASE.each_with_index do |coin, index|
      url = "https://api.coinbase.com/v2/prices/#{coin}/spot"
      response = HTTParty.get(url)
      response = response.parsed_response
      price = response['data']['amount'].to_f
      Price.create! price: price, currency: 'USD', market_id: 1, coin_id: index + 1
      @markets[:coinbase][coin] = response
    end

    BITFINEX.each_with_index do |coin, index|
      url = "https://api.bitfinex.com/v1/pubticker/#{coin}"
      response = HTTParty.get(url)
      response = response.parsed_response
      price = response['last_price'].to_f
      Price.create! price: price, currency: 'USD', market_id: 1, coin_id: index + 1
      @markets[:bitfinex][coin[0..2].upcase] = response
    end
    @markets
  end

end
