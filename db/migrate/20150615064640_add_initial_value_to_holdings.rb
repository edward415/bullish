class AddInitialValueToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :initial_value, :decimal
  end
end
