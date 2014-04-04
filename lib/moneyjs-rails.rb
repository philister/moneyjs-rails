require "moneyjs-rails/version"
require "moneyjs-rails/configuration"

module Moneyjs
  module Rails
    require "moneyjs-rails/engine"
  end

  class << self
    attr_accessor :configuration
  end
  
  def self.configure
    self.configuration ||= Moneyjs::Configuration.new
    yield(configuration)
  end
end