class Price < ApplicationRecord
  belongs_to :market
  belongs_to :coin
  extend Scopes

end
