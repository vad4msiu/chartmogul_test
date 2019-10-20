# frozen_string_literal: true

module Utils
  module_function

  def load_data(file_path)
    data = JSON.parse(File.read(file_path))

    data.each do |product_data|
      product = Product.add(
        code: product_data['code'],
        name: product_data['name'],
      )

      product_data['packs'].each do |pack_data|
        product.packs.add(
          capacity: pack_data['capacity'],
          price: pack_data['price'],
        )
      end
    end
  end

  def process_order(file_path)
    data = JSON.parse(File.read(file_path))
    order = Order.new
    data.each do |order_data|
      product = Product.find_by_code!(order_data['product_code'])
      order.items.add(
        product: product,
        quantity: order_data['quantity'],
      )
    end

    return order
  end
end
