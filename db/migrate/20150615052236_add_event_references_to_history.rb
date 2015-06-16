class AddEventReferencesToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :event_id, :integer
  end
end
