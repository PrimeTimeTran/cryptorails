# frozen_string_literal: true

class RemovePriceFromPrice < ActiveRecord::Migration[5.1]
  def change
    remove_column :prices, :price, :string
  end
end
