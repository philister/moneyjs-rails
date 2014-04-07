module Moneyjs
  
  module ViewHelpers
    
    def moneyjs_currency_rates(options={})
      only_currencies = options[:only_currencies]
      if only_currencies.blank?
        only_currencies = Moneyjs.configuration.only_currencies
      end
      
      if only_currencies.present? && !'USD'.in?(only_currencies)
        only_currencies << 'USD'
      end

      key = 'latest-currency-rates-'+Time.now.utc.strftime('%Y-%m-%d_%H')
      latest = ::Rails.cache.read(key)
      if latest.blank?
        latest = OpenExchangeRates::Rates.new.latest
        ::Rails.cache.write(key,latest)
      end
      
      if only_currencies.present?
        latest.rates.delete_if{|r| !r.in?(only_currencies)}
      end
    
      

      out = "//currency-rate from #{DateTime.strptime(latest.raw_data['timestamp'].to_s,'%s')}\n"
      out +=   "fx.base = '#{latest.base}';"
      out +=  "fx.rates = #{latest.rates.to_json};"

      if Moneyjs.configuration.default_from_currency
        out += "fx.settings = {from : '#{Moneyjs.configuration.default_from_currency}' }"
      end
      javascript_tag(out)
    end
  end
end
