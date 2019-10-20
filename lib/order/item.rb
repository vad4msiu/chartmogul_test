# frozen_string_literal: true

class Order::Item
  InvalidValue = Class.new(StandardError)
  InvalidProductQuantity = Class.new(StandardError)

  private

  attr_reader :packer

  public

  attr_reader :product, :quantity, :packs

  def initialize(product:, quantity:, packer: Order::Packer)
    if quantity <= 0
      raise(InvalidValue, 'quantity should be greater than zero')
    end

    @product = product
    @quantity = quantity
    @packer = packer
    @packs = calculate_packs
  end

  def total_price
    packs.sum(&:price)
  end

  def quantity=(value)
    @quantity = value
    @packs = calculate_packs
    @quantity
  end

  private

  def calculate_packs
    pack_capacities = packer.pack(
      target: quantity,
      capacities: product.packs.map(&:capacity),
    )

    if pack_capacities.nil?
      raise(
        InvalidProductQuantity,
        "impossible to pack #{quantity} '#{product.name}'",
      )
    end

    packs = pack_capacities.map do |pack_capacity|
      product.packs.find_by_capacity!(pack_capacity)
    end

    return packs
  end
end
