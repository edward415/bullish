class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.float :last
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
