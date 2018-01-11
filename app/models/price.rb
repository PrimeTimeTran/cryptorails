class Price < ApplicationRecord
  extend Scopes

  belongs_to :market
  belongs_to :coin
end
