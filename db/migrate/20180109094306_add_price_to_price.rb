# frozen_string_literal: true

class AddPriceToPrice < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :price, :float
  end
end
