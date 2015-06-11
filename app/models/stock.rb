class Stock < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  has_many :holdings
  belongs_to :user
  
  require 'rubygems'
  require 'savon'
  require 'pp'
  
  def quote_color
    if self.close > self.last
      return "red"
    else
      return "#83F52C"
    end
  end
  
  def arrow
    if self.close > self.last
      return "down_arrows.png"
    else
      return "up_arrows.png"
    end
  end
  
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
  
  def change_number
    change = self.last - self.close
    change = change.round(3)
    return number_with_precision(change, :precision => 3)
  end
    
  
  def get_info
    
    url = "http://globalquotes.xignite.com/v3/xGlobalQuotes.asmx?WSDL"

    soap_header = {
      "Header" => {
            "@xmlns" => "http://www.xignite.com/services/",
            "Username" => ENV['XIGNITE_KEY']
            }
        }
    client = Savon.client(wsdl: url, :soap_header => soap_header, convert_request_keys_to: :none, env_namespace: 'soap')
    
    response = client.call(:get_global_delayed_quote, message: {
      "@xmlns" => "http://www.xignite.com/services/",
	      Identifier: "#{self.symbol}.#{self.market_identification_code}",
	      IdentifierType: 'Symbol'
    })
  
    # data = pp response.to_hash
    # @symbol = data[:symbol]
    # @name = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:security][:name]
    # @last = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:last]
    # @date = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:date]
    # @time = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:time]
    # @high = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:high]
    # @low = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:low]
    # @previous_close = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:previous_close]
    # @volume = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:volume]
    # @high52_weeks = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:high52_weeks]
    # @low52_weeks = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:low52_weeks]
    # @open = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:open]
    # @ask = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:ask]
    # @bid = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:bid]
    
    # self.update_attributes(last: @last, date: @date, time: @time, name: @name, 
    # high: @high, low: @low, close: @previous_close, volume: @volume, 
    # high52_weeks: @high52_weeks, low52_weeks: @low52_weeks, start: @open, ask: @ask, bid: @bid)
    # self.save!
  end
  
end
