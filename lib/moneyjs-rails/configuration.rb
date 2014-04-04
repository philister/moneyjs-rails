module Moneyjs
  class Configuration
    attr_accessor :default_from_currency
    
    attr_reader :only_currencies
    
    def only_currencies=(currencies)
      @only_currencies = currencies
      unless 'USD'.in?(@only_currencies)
        @only_currencies << 'USD'
      end

    end
  end
end