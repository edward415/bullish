class AddBuyPriceToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :histories, :string
    add_column :histories, :buy_price, :decimal
    add_column :histories, :sell_price, :decimal
    add_column :histories, :initate_date, :datetime
  end
end
