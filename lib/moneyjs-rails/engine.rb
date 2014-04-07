require 'moneyjs-rails/view_helpers'
module Moneyjs
  module Rails
    class Engine < ::Rails::Engine
      initializer "moneyjs.view_helpers" do |app|
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end