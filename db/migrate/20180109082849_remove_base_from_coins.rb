# frozen_string_literal: true

class RemoveBaseFromCoins < ActiveRecord::Migration[5.1]
  def change
    remove_column :coins, :base, :string
    remove_column :coins, :amount, :string
  end
end
