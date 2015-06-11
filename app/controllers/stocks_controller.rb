class StocksController < ApplicationController

  # create_table "stocks", force: true do |t|
  #   t.string   "symbol"
  #   t.string   "name"
  #   t.float    "last"
  #   t.string   "date"
  #   t.string   "time"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.string   "market_identification_code"
  #   t.integer  "qty"
  #   t.integer  "user_id"
  # end
  
  def index
  end
  
  def new
    @stock = Stock.new
  end
  
  def create
    @stock = current_user.stocks.build(stock_params)
    if @stock.save
      @stock.get_info
      flash[:notice] = "Successfully Added Stock To Your Portfolio!"
      redirect_to root_path
    else
      flash[:alert] = "Failed to Add Stock! Please Try Again."
    end
  end
  
  def show
    @stock = Stock.find(params[:id])
  end
  
  def update_stock
    buy = params[:buy]
    qty = params[:holding][:qty].to_f
    stock_id = params[:stock_id]
    Stock.find(stock_id).get_info
    stock = Stock.find(stock_id)
    
    if buy == nil
      flash[:alert] = "Please select a buy or sell action."
      redirect_to stock_path(stock_id)
    end
    
    if buy == "0" #Buy
      if current_user.holdings.where(stock_id: stock_id).first #if user already has stock
        holding = current_user.holdings.find_by(stock_id: stock_id)
        average_price = (holding.price * holding.qty + stock.last * qty) / (holding.qty + qty)
        holding.update_attributes(:price => average_price,:qty => holding.qty + qty)
        flash[:notice] = "Bought #{qty} of #{stock.symbol}"
        redirect_to stock_path(stock_id)
      else #if user doesn't have stock
        holding = Holding.new(price: stock.last, qty: qty, user_id: current_user.id, stock_id: stock_id, initiate_time: Time.now)
        flash[:notice] = "Bought #{qty} of #{stock.symbol}"
        redirect_to stock_path(stock_id)
        holding.save!
      end
    
    elsif buy == "1" #Sell
      if current_user.holdings.where(stock_id: stock_id).first #if user already has stock
        holding = current_user.holdings.find_by(stock_id: stock_id)
        if holding.qty - qty >= 0
          holding.update_attribute(:qty, holding.qty - qty)
          flash[:notice] = "Sold #{qty} of #{Stock.find(stock_id).symbol}"
          redirect_to stock_path(stock_id)
          if holding.qty == 0
            holding.delete!
            flash[:notice] = "Your position in #{stock.symbol} has been closed"
          end
        else #if user doesn't have stock
          flash[:alert] = "Insufficient shares to sell, the maximum shares you can sell is the number of shares you own."
          redirect_to stock_path(stock_id)
        end
      else #if user tries to sell with no stock in  holdings
        flash[:alert] = "You don't hold shares of #{stock.symbol} yet."
        redirect_to stock_path(stock_id)
      end
    end
    
  end
  
  private
  
  def stock_params
    params.require(:stock).permit(:symbol, :market_identification_code, :qty)
  end
  

end
