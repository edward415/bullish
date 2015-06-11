class AddHighToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :high, :float
    add_column :stocks, :low, :float
    add_column :stocks, :close, :float
    add_column :stocks, :high52_weeks, :float
    add_column :stocks, :low52_week, :float
  end
end
