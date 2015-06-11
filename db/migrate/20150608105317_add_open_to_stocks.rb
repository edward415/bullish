class AddOpenToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :open, :float
  end
end
