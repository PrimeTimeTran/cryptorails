# frozen_string_literal: true

class AddCurrencyToPrice < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :currency, :string
  end
end
