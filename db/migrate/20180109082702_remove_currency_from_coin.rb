class RemoveCurrencyFromCoin < ActiveRecord::Migration[5.1]
  def change
    remove_column :coins, :currency, :string
  end
end
