# frozen_string_literal: true

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

    def weekly
      where('created_at >= ?', 1.week.ago)
    end

    def weekly_highs
      weekly_prices.map { |_, v| v.max_by(&:price) }
    end

    def weekly_lows
      weekly_prices.map { |_, v| v.min_by(&:price) }
    end

    def weekly_prices
      weekly.group_by { |x| x.created_at.strftime('%Y-%m-%d') }
    end

    # Building data for front end

    def create_candlestick(group)
      {
        date: group[0],
        open: opening_price(group[1]),
        close: closing_price(group[1]),
        low: lowest_price(group[1]),
        high: highest_price(group[1])
      }
    end

    def opening_price(group)
      group.inject { |memo, price| memo.created_at < price.created_at ? memo : price }.price
    end

    def closing_price(group)
      group.inject { |memo, price| memo.created_at > price.created_at ? memo : price }.price
    end

    def highest_price(group)
      group.collect(&:price).max
    end

    def lowest_price(group)
      group.collect(&:price).min
    end

    def five_minute_prices
      time = Time.zone.now.end_of_day
      first_price = Price.first.created_at
      prices = {}

      while first_price < time
        earlier_time = time - 300
        later_time = time
        prices[time] = []
        r = Range.new(earlier_time, later_time)
        Price.all.each { |price| prices[time] << price if r.cover?(price.created_at) }
        time -= 300
      end
      prices.reject { |_, value| value.empty? }
    end

    def candlestick_data
      prices = five_minute_prices.map do |group|
        create_candlestick(group)
      end
      prices.reverse
    end

    def write_to_tsv
      CSV.open('prices.tsv', 'wb', col_sep: "\t") do |tsv|
        tsv << %w[date open close low high]
        candlestick_data.each do |data|
          tsv << [data[:date], data[:open], data[:close], data[:low], data[:high]]
        end
      end
    end
  end
end
