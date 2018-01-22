# frozen_string_literal: true

module SendPriceJob
  @queue = :price_serve

  def self.perform
    conn = Bunny.new ENV['CLOUDAMQP_URL']
    conn.start

    ch  = conn.create_channel
    x   = ch.default_exchange
    q   = ch.queue('current_prices')

    puts '[*] Waiting for current_prices. To exit press CTRL+C'
    begin
      q.subscribe(block: true) do |_, _, body|
        puts "Now subscribed to the queue #{q}"
        puts "Default queue:#{x}"
        puts " [x] #{body}"
        ActionCable.server.broadcast 'prices', body
      end
    rescue Interrupt => _
      ch.close
      conn.close
    end
  end
end
