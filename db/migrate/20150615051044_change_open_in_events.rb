class ChangeOpenInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :open, :initiate
  end
end
