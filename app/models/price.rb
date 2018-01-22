# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :market
  belongs_to :coin
  searchkick
  extend Scopes

  def self.recent_price
    binding.pry
    self.search(aggs: {five_minute_interval: {date_histogram: {field: 'created_at', interval: '5m' }}}).response['aggregations']['five_minute_interval']['buckets']
    self.search(aggs: {five_minute_interval: {date_histogram: {field: 'created_at', interval: '5m' }}})
  end
end
