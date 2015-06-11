class AddPriceToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :price, :decimal
  end
end
