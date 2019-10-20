# frozen_string_literal: true

class Product
  InvalidValue = Class.new(StandardError)
  NotFound = Class.new(StandardError)

  CURRENCY = Money::Currency.find('USD')

  class << self
    private

    def store
      @store ||= {}
    end

    public

    def add(code:, name:)
      raise(InvalidValue, 'code can not be nil') if code.nil?
      raise(InvalidValue, 'name can not be nil') if name.nil?
      raise(InvalidValue, 'code should be unique') if store.key?(code)

      store[code] = Product.new(code: code, name: name)

      return store[code]
    end

    def find_by_code!(code)
      unless store.key?(code)
        raise(NotFound, "can not find a product with code '#{code}'")
      end

      return store[code]
    end

    def delete_all
      @store = {}
    end
  end

  attr_reader :packs

  public

  attr_accessor :code, :name

  def initialize(code:, name:)
    @code = code
    @name = name
    @packs = Pack::Collection.new
  end
end
