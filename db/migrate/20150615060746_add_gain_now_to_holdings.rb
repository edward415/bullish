class AddGainNowToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :gain_now, :decimal
  end
end
