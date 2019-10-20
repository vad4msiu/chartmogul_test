# frozen_string_literal: true

class Order
  attr_reader :items

  def initialize
    @items = Order::Collection.new
  end

  def to_s
    info = ''

    items.each do |item|
      info += "#{item.quantity} #{item.product.code} #{item.total_price.format}\n"

      item.packs.group_by(&:capacity).each do |pack_capacity, packs|
        info += "  #{packs.size} x #{pack_capacity} #{packs.first.price.format}\n"
      end
    end

    return info
  end
end
