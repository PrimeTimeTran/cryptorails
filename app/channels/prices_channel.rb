# frozen_string_literal: true

class PricesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'prices'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
