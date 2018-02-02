require 'uri'
require 'net/http'

url = URI("https://api.bitfinex.com/v2/calc/trade/avg")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Post.new(url)

response = http.request(request)
puts response.read_body


# Coinbase

# Bitfinex
# https://api.bitfinex.com/v1/pubticker/btcusd

# Bittrex
# https://bittrex.com/api/v1.1/public/getmarketsummary?market=usdt-btc

