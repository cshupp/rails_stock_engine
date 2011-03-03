require 'json'

class StockEngineController < ApplicationController
  before_filter :header_gwt
  def stocks_as_json
  	#raise "I am broken"
  	stocks = []
    stocks = params["stocks"].split(',') unless params["stocks"].nil?
    @stocks = {}
    stocks.each do |stock|
    	@stocks[stock] = stock_price
    end
    parm = params
#    stocks = stocks.to_s
 #   @stocks ={"all_stocks" => {"current_price"=>stocks,"low"=>["12".to_f,Time.now.to_s],"hi"=>"100"},"stock1" => {"current_price"=>"50.5","low"=>"1","hi"=>"100"}, "stock2" => {"current_price"=>"60.5","low"=>"2","hi"=>"200"}}
    respond_to do |wants|
      wants.json { render :text => @stocks.to_json, :status => 200}
      wants.html # will default to the erb displaying text json data
    end
  end

  def header_gwt
    response.headers['Content-type'] = 'text/javascript'
    response.headers['Cache-Control'] = 'no-cache'
    response.headers['Pragma'] = 'no-cache'
  end
  
  private
  
  def stock_price
  	price = 1 + rand(100)
  	price = price.to_s << "." <<(1 + rand(10)).to_s << (1 + rand(10)).to_s
  	price = price.to_f
  	sign = rand(2)==0 ? "+":"-"
  	change = rand
  	change = sign << change.to_s
  	change = change.to_f
  	[price,change]
  end
  
  	
end
