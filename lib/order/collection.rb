# frozen_string_literal: true

class Order::Collection
  include Enumerable

  private

  attr_reader :store

  public

  def initialize
    @store = {}
  end

  def add(product:, quantity:)
    if store.key?(product.code)
      store[product.code].quantity += quantity
    else
      store[product.code] = Order::Item.new(
        product: product,
        quantity: quantity,
      )
    end

    item = store[product.code]

    return item
  end

  def each
    store.values.each { |item| yield item }
  end
end
