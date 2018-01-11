class Price < ApplicationRecord
  module Scopes
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
  end
end
