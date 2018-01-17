# frozen_string_literal: true

class FetchPriceJob
  @queue = :update_price

  # COINBASE = ['BTC-USD', 'ETH-USD']
  # BITFINEX = ['btcusd', 'ethusd', 'etcusd']
  COINBASE = ['BTC-USD'].freeze

  def self.perform
    COINBASE.each_with_index do |coin, index|
      url = "https://api.coinbase.com/v2/prices/#{coin}/spot"
      response = HTTParty.get(url)
      response = response.parsed_response
      Price.create! price: price, currency: 'USD', market_id: 1, coin_id: index + 1
      data = {}
      data[:html] = response
      ActionCable.server.broadcast 'prices', data
    end

    # BITFINEX.each_with_index do |coin, index|
    #   url = "https://api.bitfinex.com/v1/pubticker/#{coin}"
    #   response = HTTParty.get(url)
    #   response = response.parsed_response
    #   price = response['last_price'].to_f
    #   Price.create! price: price, currency: 'USD', market_id: 1, coin_id: index + 1
    # end
  end
end
