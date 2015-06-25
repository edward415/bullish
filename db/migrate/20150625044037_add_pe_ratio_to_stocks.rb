class AddPeRatioToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :pe_ratio, :float
    add_column :stocks, :market_cap, :string
  end
end
