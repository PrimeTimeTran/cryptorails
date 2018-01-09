class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :base
      t.integer :currency
      t.integer :amount

      t.timestamps
    end
  end
end
