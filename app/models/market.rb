# frozen_string_literal: true

class Market < ApplicationRecord
  has_many :coins
end
