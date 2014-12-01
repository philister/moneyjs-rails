# moneyjs-rails

Since we needed to add foreign currency to pictrs.com (Welcome Swtzerland to Europe!), we decided to do it just clientside with the great [Money.js](http://josscrowcroft.github.io/money.js/)
You maybe want to use it with
https://github.com/torbjon/accountingjs-rails


## Install

Add it to your Rails application's `Gemfile`:

```ruby
gem 'moneyjs-rails'
```

Then `bundle install`.


### Setup Exchange Rates via openexchangerates.org (optional)

Add this line to your application's Gemfile:

    gem 'open_exchange_rates'

And then execute:

    $ bundle

If you are using Rails good place to add this is config/initializers/open_exchange_rates.rb

    OpenExchangeRates.configure do |config|
      config.app_id = "YourAppID"
    end

To save Bytes you can configure to use only specific cureencies, e.g. in config/initializers/moneyjs.rb

    Moneyjs.configure do |config|
      config.only_currencies = ['CHF','EUR']
    end

At the same place you can define your default currency,

    config.default_from_currency = 'EUR'
 so you can use (see Usage)
    fx(1000).to("CHF");



## Usage

Add the following to your `app/assets/javascripts/application.js`:

    //= require moneyjs

If you've set up the exchange rates via openexchangerates.org above, add to `app/views/layouts/application.html.erb`

    <%= moneyjs_currency_rates %>



Otherwise do it your self like this:
  
    fx.base = "EUR";
    fx.rates = {
      "EUR" : 1, // needed 
      "GBP" : 0.647710, // replace, its wrong !
      "HKD" : 7.781919, // replace, its wrong !
      "USD" : 1.4, // replace, its wrong !
      
    }


Then you can:
      
    // From any currency, to any currency:
    fx.convert(12.99, {from: "EUR", to: "CHF"});

    // Chaining sugar:
    fx(1000).from("USD").to("GBP");
    fx(1000).to("AED");

    // With simple settings and defaults, making this possible:
    fx.convert(5318008);
    fx(5318008).to("AED");

See the full usage details on the [money.js](http://josscrowcroft.github.io/money.js/) site with a fancy playground.

