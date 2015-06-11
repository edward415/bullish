class ChangeColoumnName < ActiveRecord::Migration
  def change
    rename_column :stocks, :low52_week, :low52_weeks
  end
end
