require 'bunny'
conn = Bunny.new
conn.start

ch   = conn.create_channel

q    = ch.queue("hello")
ch.default_exchange.publish("Hello does this work?!", :routing_key => q.name)
puts ch
puts " [x] Sent 'Hello World!'"
conn.close


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