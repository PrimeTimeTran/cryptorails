
if Coin.first.nil?
  puts "Seeding Coins:"
  Coin.create! name: 'BitCoin'
  Coin.create! name: 'Ethereum'
  Coin.create! name: 'Ethereum Classic'
end

if Market.first.nil?
  puts "Seeding Markets:"
  Market.create! name: 'Coinbase'
  Market.create! name: 'Bitfinex'
  Market.create! name: 'Bittrex'
end

if Price.count == 0
  time = Time.now
  price = 10000
  250.times do
    coin =  Price.new coin_id: 1, market_id: 1, price: price, currency: 'USD', created_at: time
    coin.save
    4.times do
      coin = Price.new coin_id: 1, market_id: 1, price: price + rand(-200..200), currency: 'USD', created_at: time
      coin.save
      time += 60
    end
    time += 60
    price += rand(-400..410)
  end
end