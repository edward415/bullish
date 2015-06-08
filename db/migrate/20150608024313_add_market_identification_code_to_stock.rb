class AddMarketIdentificationCodeToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :market_identification_code, :string
  end
end
