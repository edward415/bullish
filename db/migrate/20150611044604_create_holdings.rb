class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.integer :qty
      t.datetime :initiate_time
      t.references :stock, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
