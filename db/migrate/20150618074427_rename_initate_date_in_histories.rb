class RenameInitateDateInHistories < ActiveRecord::Migration
  def change
    rename_column :histories, :initate_date, :initiate_date
  end
end
