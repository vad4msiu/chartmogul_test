# frozen_string_literal: true

class Pack::Collection
  include Enumerable

  InvalidValue = Class.new(StandardError)
  NotFound = Class.new(StandardError)

  private

  attr_reader :store

  public

  def initialize
    @store = {}
  end

  def add(capacity:, price:)
    if store.key?(capacity)
      raise(InvalidValue, 'pack capacity should be unique')
    end

    store[capacity] = Pack.new(capacity: capacity, price: price)

    return store[capacity]
  end

  def find_by_capacity!(capacity)
    unless store.key?(capacity)
      raise(NotFound, "can not find a pack with capacity '#{capacity}'")
    end

    return store[capacity]
  end

  def each
    store.values.each { |item| yield item }
  end
end
