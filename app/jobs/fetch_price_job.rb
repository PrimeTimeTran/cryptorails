# frozen_string_literal: true

class FetchPriceJob
  @queue = :update_price

  def self.perform
    # Coinbase
    url = 'https://api.coinbase.com/v2/prices/BTC-USD/spot'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['data']['amount'].to_i
    Price.create! price: price, currency: 'USD', market_id: 1, coin_id: 1

    url = 'https://api.coinbase.com/v2/prices/ETH-USD/spot'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['data']['amount'].to_i
    Price.create! price: price, currency: 'USD', market_id: 1, coin_id: 2

    # Bitfinex
    url = 'https://api.bitfinex.com/v1/pubticker/btcusd'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['bid'].to_f
    Price.create! price: price, currency: 'USD', market_id: 2, coin_id: 1

    url = 'https://api.bitfinex.com/v1/pubticker/ethusd'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['bid'].to_f
    Price.create! price: price, currency: 'USD', market_id: 2, coin_id: 2

    url = 'https://api.bitfinex.com/v1/pubticker/etcusd'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['bid'].to_f
    Price.create! price: price, currency: 'USD', market_id: 2, coin_id: 3

    # Bittrex
    url = 'https://bittrex.com/api/v1.1/public/getmarketsummary?market=usdt-btc'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['result'].first['Bid']
    Price.create! price: price, currency: 'USD', market_id: 3, coin_id: 1

    url = 'https://bittrex.com/api/v1.1/public/getmarketsummary?market=usdt-eth'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['result'].first['Bid']
    Price.create! price: price, currency: 'USD', market_id: 3, coin_id: 3

    response = Price.most_recent
    response['chart'] = Price.recent_prices
    FetchPriceJob.new.publish(response.to_json)
  end

  def publish(data)
    queue.publish(data, routing_key: queue.name)
  end

  def connection
    @conn ||= begin
      conn = Bunny.new(host: 'localhost', vhost: '/', user: 'guest', password: 'guest')
      conn.start
    end
  end

  def channel
    @channel ||= connection.create_channel
  end

  def queue
    @queue ||= channel.queue('current_prices')
  end
end


# time = Time.now
# price = 10000

# 1000.times do
#   Price.create! coin_id: 1, market_id: 1, price: price, currency: 'USD', created_at: time
#   4.times do
#     Price.create! coin_id: 1, market_id: 1, price: price + rand(-200..200), currency: 'USD', created_at: time
#     time += 60
#   end
#   time += 60
#   price += rand(-400..410)
# end