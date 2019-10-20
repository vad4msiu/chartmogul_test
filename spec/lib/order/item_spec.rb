# frozen_string_literal: true

describe Order::Item do
  let(:quantity) { 4 }
  let(:product) { Product.new(code: 'some_code', name: 'some_name') }

  before { product.packs.add(capacity: 2, price: 10) }

  describe '.new' do
    subject { described_class.new(quantity: quantity, product: product) }

    context 'when quantity is negative' do
      let(:quantity) { -1 }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'with incorrect product quantities' do
      let(:quantity) { 1 }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidProductQuantity)
      end
    end

    context 'with correct product quantities' do
      it 'returns order item with calculated packs' do
        expect(subject.packs).to_not be_nil
      end
    end
  end
end
