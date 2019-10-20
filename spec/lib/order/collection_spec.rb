# frozen_string_literal: true

describe Order::Collection do
  let(:quantity) { 1 }
  let(:product) { Product.new(code: 'some_code', name: 'some_name') }
  let(:order_collection) { described_class.new }

  before { product.packs.add(capacity: 1, price: 10) }

  describe '#add' do
    subject { order_collection.add(quantity: quantity, product: product) }

    context 'when there is the same product' do
      before { order_collection.add(quantity: quantity, product: product) }

      it 'increases quantity' do
        expect {
          subject
        }.to change {
          order_collection.detect { |item|
            item.product == product
          }.quantity
        }.from(quantity).to(quantity * 2)
      end
    end

    context 'when there is no the same product' do
      it 'adds a product with quantity' do
        expect {
          subject
        }.to change {
          order_collection.detect { |item|
            item.product == product
          }&.quantity
        }.from(nil).to(quantity)
      end
    end
  end
end
