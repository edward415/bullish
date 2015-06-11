class AddGainPctToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :pct_gain, :decimal
  end
end
