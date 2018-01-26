# frozen_string_literal: true

module SendPriceJob
  @queue = :price_serve

  def self.perform
    conn = Bunny.new ENV['CLOUDAMQP_URL']
    conn.start
    ch  = conn.create_channel
    x   = ch.default_exchange
    q   = ch.queue('current_prices')
    begin
      q.subscribe(block: true) { |_, _, body| ActionCable.server.broadcast 'prices', body }
    rescue Interrupt => _
      ch.close
      conn.close
    end
  end
end
