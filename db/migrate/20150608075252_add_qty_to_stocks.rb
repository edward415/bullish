class AddQtyToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :qty, :integer
  end
end
