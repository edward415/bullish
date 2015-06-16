class FeedController < ApplicationController
  def index
    @events = Event.all
    @holdings = Holding.all
  end
  
end
