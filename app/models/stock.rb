class Stock < ActiveRecord::Base
  require 'rubygems'
  require 'savon'
  require 'pp'
  
  # attr_reader :symbol, :name, :last, :date
  
  def get_info
    puts ENV['XIGNITE_KEY']
    puts "*" * 15
    
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
  
    data = pp response.to_hash
    @symbol = data[:symbol]
    @name = data[:name]
    @last = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:last]
    @date = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:date]
    @time = data[:get_global_delayed_quote_response][:get_global_delayed_quote_result][:time]

    puts data[:get_global_delayed_quote_response][:get_global_delayed_quote_result]
  
    self.update_attributes(last: @last, date: @date, time: @time)
    
  end
  
end
