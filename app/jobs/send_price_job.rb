# frozen_string_literal: true

module SendPriceJob
  @queue = :price_serve

  def self.perform
    conn = Bunny.new(host: 'localhost', vhost: '/', user: 'guest', password: 'guest')
    conn.start
    ch  = conn.create_channel
    x   = ch.default_exchange
    q   = ch.queue('current_prices')
    begin
      q.subscribe(block: true, manual_ack: true) do |delivery_info, _properties, body|
        puts "\n\n\n Subscribed"
        ActionCable.server.broadcast 'prices', body
        ch.acknowledge(delivery_info.delivery_tag, false)
      end
    rescue Interrupt => _
      ch.close
      conn.close
    end
  end
end
