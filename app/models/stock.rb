class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_ticker
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    begin
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
      price = strip_comas(looked_up_stock.l)
      new(name: looked_up_stock.name, ticker: looked_up_stock.symbol, last_price: price )
    rescue Exception => e
      return nil
    end
  end

  def self.strip_comas(number)
    number.gsub(",", "")
  end
end
