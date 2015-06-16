class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.references :stock, index: true
      t.boolean :buy
      t.integer :qty
      t.decimal :price

      t.timestamps
    end
  end
end
