# frozen_string_literal: true

class Price < ApplicationRecord
  include Filterable
  extend Scopes

  belongs_to :market
  belongs_to :coin
end
