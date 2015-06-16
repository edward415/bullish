class AddOpenAndCloseInEvents < ActiveRecord::Migration
  def change
    add_column :events, :open, :boolean
    add_column :events, :close, :boolean
  end
end
