class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :market, foreign_key: true
      t.references :coin, foreign_key: true

      t.timestamps
    end
  end
end
