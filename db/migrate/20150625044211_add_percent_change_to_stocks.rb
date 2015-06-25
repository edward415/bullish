class AddPercentChangeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :percent_change, :string
  end
end
