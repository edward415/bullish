class AddVolumeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :volume, :integer
  end
end
