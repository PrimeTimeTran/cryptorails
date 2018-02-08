# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
time = Time.now
price = 7000

250.times do
  Price.create! coin_id: 1, market_id: 3, price: price, currency: 'USD', created_at: time
  4.times do
    Price.create! coin_id: 1, market_id: 3, price: price + rand(-200..200), currency: 'USD', created_at: time
    time += 60
  end
  time += 60
  price += rand(-400..410)
end
