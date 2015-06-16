module FeedHelper
  def link_stock(e)
    link_to "#{Stock.find(e.stock_id).symbol}", stock_path(Stock.find(e.stock_id))
  end
  
  def gain_color(e)
    if e.history.pct_gain > 0
      return "green"
    elsif e.history.pct_gain < 0
      return "red"
    end
  end
  
  def link_user(e)
    link_to "#{User.find(e.user_id).name}", user_path(e.user_id)
  end
end
