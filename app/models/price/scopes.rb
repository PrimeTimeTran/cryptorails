class Price < ApplicationRecord
  module Scopes
    def btc
      where(coin_id: 1)
    end

    def eth
      where(coin_id: 2)
    end

    def etc
      where(coin_id: 3)
    end

    def daily
      created_at.to_date.to_s(:db)
    end

    def weekly_highs
      weekly_prices.map do |k, v|
        v.max_by(&:price)
      end
    end

    def weekly_lows
      weekly_prices.map do |k, v|
        v.min_by(&:price)
      end
    end

    def weekly_prices
      weekly.group_by{|x| x.created_at.strftime("%Y-%m-%d")}
    end

    def weekly
      where('created_at >= ?', 1.week.ago)
    end






    # Building data for front end

    def create_candlestick(group)
      {
        open: opening_price(group[1]),
        close: closing_price(group[1]),
        low: lowest_price(group[1]),
        high: highest_price(group[1])
      }
    end

    def opening_price(group)
      group.inject {|memo, price| memo.created_at < price.created_at ? memo : price }.price
    end

    def closing_price(group)
      group.inject {|memo, price| memo.created_at > price.created_at ? memo : price }.price
    end

    def highest_price(group)
      group.collect {|p| p.price }.max
    end

    def lowest_price(group)
      group.collect {|p| p.price }.min
    end

    def five_minute_prices
      time = Time.zone.now.end_of_day
      first_price = Price.first.created_at
      prices = {}

      while first_price < time
        previous_time = time - 300
        current_time = time
        prices[time] = []
        r = Range.new(previous_time, current_time)
        Price.all.each do |price|
          prices[time] << price if r.cover?(price.created_at)
        end
        time -= 300
      end
      prices.reject { |key,value| value.empty? }
    end

    def candlestick_data
      groups = {}
      five_minute_prices.map do |group|
        groups[group[0]] = create_candlestick(group)
      end
      groups
    end

  end
end












