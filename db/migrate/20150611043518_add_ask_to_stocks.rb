class AddAskToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :ask, :float
    add_column :stocks, :bid, :float
    remove_column :stocks, :qty
  end
end
