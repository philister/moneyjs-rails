module Moneyjs
  
  module ViewHelpers
    
    def moneyjs_currency_rates(options={})
      outdated = false
      only_currencies = options[:only_currencies]
      if only_currencies.blank?
        only_currencies = Moneyjs.configuration.only_currencies
      end
      
      if only_currencies.present? && !'USD'.in?(only_currencies)
        only_currencies << 'USD'
      end


      

      key = 'latest-currency-rates-'+Time.now.utc.strftime('%Y-%m-%d_%H')
      
      latest = ::Rails.cache.read(key)
      if latest.blank? or latest.rates.blank?
        latest = OpenExchangeRates::Rates.new.latest
        ::Rails.cache.write(key,latest) unless latest.blank? or latest.rates.blank?
      end

      if latest.blank? or latest.rates.blank?
        outdated = true
        # OER didnt deliver rates, try to get one of the latest
        i = 0
        while (latest.blank? || latest.rates.blank?) && i < 100
          i+=1
          key = 'latest-currency-rates-'+(Time.now.utc - i.hours).strftime('%Y-%m-%d_%H')
          latest = ::Rails.cache.read(key)
        end
      end
      
      if latest.blank? or latest.rates.blank?
        raise "sorry, could not retrieve exchangerates via cache nor OER-API \n" + 'latest API-response is: ' + OpenExchangeRates::Rates.new.latest.inspect
      end

      if only_currencies.present?
        latest.rates.delete_if{|r| !r.in?(only_currencies)}
      end
    
      

      out = "// currency-rates from #{DateTime.strptime(latest.raw_data['timestamp'].to_s,'%s')}\n"
      out += "// they are maybe outdated\n" if outdated
      out +=   "fx.base = '#{latest.base}';"
      out +=  "fx.rates = #{latest.rates.to_json};"

      if Moneyjs.configuration.default_from_currency
        out += "fx.settings = {from : '#{Moneyjs.configuration.default_from_currency}' }"
      end
      javascript_tag(out)
    end
  end
end
