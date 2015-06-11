class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.decimal :gain
      t.references :stock, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
