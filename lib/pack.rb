# frozen_string_literal: true

class Pack
  InvalidValue = Class.new(StandardError)
  CURRENCY = Money::Currency.find('USD')

  attr_accessor :capacity, :price

  def initialize(capacity:, price:)
    if capacity <= 0
      raise(InvalidValue, 'capacity should be greater than zero')
    end

    if price <= 0
      raise(InvalidValue, 'price should be greater than zero')
    end

    @capacity = capacity
    @price = Money.new(price * CURRENCY.subunit_to_unit, CURRENCY)
  end
end
