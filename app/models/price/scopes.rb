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

    def open
      price[1].inject {|memo, price| price.created_at < memo.created_at ? price : memo }
    end

    def close
      price[1].inject {|memo, price| price.created_at < memo.created_at ? price : memo }
    end

    def five_minute_prices
      time = Time.zone.now.end_of_day
      first_price = Price.first.created_at
      prices = {}

      while first_price < time
        previous_time = time - 300
        current_time = time
        prices[time.to_s] = []
        r = Range.new(previous_time, current_time)
        Price.all.each do |price|
          prices[time] << price if r.cover?(price.created_at)
        end
        time -= 300
      end
      prices.reject { |key,value| value.empty? }
    end
  end
end












