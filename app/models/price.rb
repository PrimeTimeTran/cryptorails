# frozen_string_literal: true

class Price < ApplicationRecord
  extend Scopes
  belongs_to :market
  belongs_to :coin
  searchkick

  def self.most_recent
    { data: { base: 'BTC', currency: 'USD', amount: last.price } }
  end

  def self.recent_prices
    search = query_elastic

    return [] unless search.aggregations.present?
    time_intervals = search.aggregations.dig('five_time_intervals', 'buckets')
    time_intervals.inject([]) do |interval, i|
    interval <<
      if i.dig('lowest', 'hits', 'hits').present?
        Hashie::Mash.new(
          date: i.dig('open', 'hits', 'hits').first.dig('_source', 'created_at'),
          open: i.dig('open', 'hits', 'hits').first.dig('_source', 'price'),
          high: i.dig('highest', 'hits', 'hits').first.dig('_source', 'price'),
          low:  i.dig('lowest', 'hits', 'hits').first.dig('_source', 'price'),
          close: i.dig('close', 'hits', 'hits').first.dig('_source', 'price')
        )
      end
    end
  end

  def self.query_elastic(coin = 1)
    search(
      where: { coin_id: coin },
        body_options: {
          aggs: { five_time_intervals: { date_histogram: { field: :created_at, interval: '5m', min_doc_count: 1 },
            aggs: {
              highest: { top_hits: { sort: [{ price: { order: 'desc' } }], _source: { includes: ['price'] }, size: 1 } },
              lowest: { top_hits: { sort: [{ price: { order: 'asc' } }], _source: { includes: ['price'] }, size: 1 } },
              open: { top_hits: { sort: [{ created_at: { order: 'asc' } }], _source: { includes: ['price', 'created_at'] }, size: 1 } },
              close: { top_hits: { sort: [{ created_at: { order: 'desc' } }], _source: { includes: ['price'] }, size: 1 } }
            }
          }
        }
      }
    )
  end
end



