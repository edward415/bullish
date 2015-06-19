module ApplicationHelper
  def change_percentage
    if self.last > self.close
      change = (self.last - self.close)/self.close
    elsif self.last == self.close
      change = 0
    else
      change = (self.close - self.last)/self.close
    end
    change *= 100
    return number_to_percentage(change)
  end
  

  
  def gain_now_color(h)
    if h.gain_now > 0
      return "green"
    elsif h.gain_now < 0
      return "red"
    end
  end
end
