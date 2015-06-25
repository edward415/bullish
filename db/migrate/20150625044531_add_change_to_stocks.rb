class AddChangeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :change, :float
  end
end
