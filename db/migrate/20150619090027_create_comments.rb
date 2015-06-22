class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
