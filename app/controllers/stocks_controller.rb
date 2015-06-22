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
      redirect_to root_path, notice: "Successfully Added Stock To Your Portfolio!"
    else
      flash[:alert] = "Failed to Add Stock! Please Try Again."
      render :new
    end
  end
  
  def show
    @stock = Stock.find(params[:id])
  end
  
  def update_holding
    raise
    @buy = params[:buy]
    @qty = params[:holding][:qty].to_i
    @symbol = params[:symbol]
    
    if Stock.where(symbol: @symbol).first
      @stock_id = Stock.find_by(symbol: @symbol).id
    else
      flash[:alert] = "invalid stock"
      redirect_to root_path and return
    end
    
    Stock.find(@stock_id).get_info
    @stock = Stock.find(@stock_id)
    @holding = current_user.holdings.find_by(stock_id: @stock_id)
    
    stock_actions
    
  end
  
  def stock_actions
    
    if @buy == nil
      flash[:alert] = "Please select a buy or sell action."
      redirect_to stock_path(stock_id)
    end
    
    if @buy == "0" #Buy
      if current_user.holdings.where(stock_id: @stock_id).first #if user already has stock
        average_price = (@holding.price * @holding.qty + @stock.last * @qty) / (@holding.qty + @qty)
        @holding.update_attributes(:price => average_price,:qty => @holding.qty + @qty, :initial_value => average_price * (@holding.qty + @qty))
        buy_event(false)
        flash[:notice] = "Bought #{@qty} of #{@stock.symbol}"
        redirect_to stock_path(@stock_id)
      else #if user doesn't have stock
        new_holding = Holding.new(price: @stock.last, qty: @qty, user_id: current_user.id, stock_id: @stock_id, initiate_time: Time.now, gain_now: 0, initial_value: @stock.last * @qty)
        buy_event(true)
        flash[:notice] = "Bought #{@qty} of #{@stock.symbol}"
        redirect_to stock_path(@stock_id)
        new_holding.save!
      end
    
    elsif @buy == "1" #Sell
      if current_user.holdings.where(stock_id: @stock_id).first #if user already has stock
        if @holding.qty - @qty >= 0
          @holding.update_attribute(:qty, @holding.qty - @qty)
          if @holding.qty != 0
            @holding.update_attribute(:gain_now, calc_gain)
            sell_event(false)
          end
          flash[:notice] = "Sold #{@qty} of #{Stock.find(@stock_id).symbol}"
          redirect_to stock_path(@stock_id)
          
          if @holding.qty == 0 #Close Position
            sell_event(true)
            create_history
            @holding.delete
            flash[:notice] = "Your position in #{@stock.symbol} has been closed"
          end
        else #if user doesn't have stock
          flash[:alert] = "Insufficient shares to sell, the maximum shares you can sell is the number of shares you own."
          redirect_to stock_path(@stock_id)
        end
      else #if user tries to sell with no stock in  holdings
        flash[:alert] = "You don't hold shares of #{@stock.symbol} yet."
        redirect_to stock_path(@stock_id)
      end
    end
  end
  
  def calc_gain
    init_value = @qty * @holding.price
    sell_value = @qty * @stock.last
    
    if sell_value >= init_value
      @gain = sell_value - init_value
    else
      @gain = -(init_value - sell_value)
    end
    return @gain.round(2)
  end
      
  def buy_event(initiate)
    @event = Event.new(user_id: current_user.id, stock_id: @stock.id, qty: @qty, price: @stock.last, buy: true, initiate: initiate)
    @event.save!
  end
  
  def sell_event(close)
    @event = event = Event.new(user_id: current_user.id, stock_id: @stock.id, qty: @qty, price: @stock.last, buy: false, close: close)
    @event.save!
  end
  
  def create_history
    @gain = calc_gain + @holding.gain_now
    @pct_gain = @gain  / @holding.initial_value
    if @gain == 0
      @pct_gain = 0
    end
    history = History.new(user_id: current_user.id, stock_id: @stock.id, gain: @gain, pct_gain: @pct_gain, event_id: @event.id, buy_price: @holding.price, initiate_date: @holding.initiate_time)
    history.save!
  end

  
  private
  

  
  def stock_params
    params.require(:stock).permit(:symbol, :market_identification_code, :qty)
  end
  

end
