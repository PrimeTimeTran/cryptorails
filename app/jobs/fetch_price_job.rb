# frozen_string_literal: true

class FetchPriceJob
  @queue = :update_price

  def self.perform
    url = 'https://api.coinbase.com/v2/prices/BTC-USD/spot'
    response = HTTParty.get(url)
    response = response.parsed_response
    price = response['data']['amount'].to_i
    Price.create! price: price, currency: 'USD', market_id: 1, coin_id: 1
    response['chart'] = Price.recent_prices
    FetchPriceJob.new.publish(response.to_json)
  end

  def publish(data)
    queue.publish(data, routing_key: queue.name)
  end

  def connection
    @conn ||= begin
      conn = Bunny.new(host: "localhost", vhost: "/", user: "guest", password: "guest")
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
