# frozen_string_literal: true

class AddNameToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :name, :string
  end
end
