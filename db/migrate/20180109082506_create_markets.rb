# frozen_string_literal: true

class CreateMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :markets do |t|
      t.string :name

      t.timestamps
    end
  end
end
