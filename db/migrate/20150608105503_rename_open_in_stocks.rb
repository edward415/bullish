class RenameOpenInStocks < ActiveRecord::Migration
  def change
    rename_column :stocks, :open, :start
  end
end
