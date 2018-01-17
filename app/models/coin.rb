# frozen_string_literal: true

class Coin < ApplicationRecord
  has_many :prices
end
