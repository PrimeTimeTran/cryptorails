# frozen_string_literal: true

module SendPriceJob
  @queue = :price_serve

  def self.perform
    conn = Bunny.new(host: "localhost", vhost: "/", user: "guest", password: "guest")
    conn.start
    ch  = conn.create_channel
    x   = ch.default_exchange
    q   = ch.queue('current_prices')
    begin
      # Let them know we've received the message. Acknowledge the message.
      # Set up our own RabbitMQ
      q.subscribe(block: true) do |_, _, body|
        ActionCable.server.broadcast 'prices', body
      end
    rescue Interrupt => _
      ch.close
      conn.close
    end
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