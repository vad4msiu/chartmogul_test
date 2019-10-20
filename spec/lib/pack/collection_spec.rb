# frozen_string_literal: true

describe Pack::Collection do
  let(:capacity) { 1 }
  let(:price) { 10 }
  let(:pack_collection) { described_class.new }

  describe '#add' do

    subject { pack_collection.add(capacity: capacity, price: price) }

    context 'when there is a pack with the same capacity' do
      before { pack_collection.add(capacity: capacity, price: price) }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'when there is no pack with the same capacity' do
      it 'returns a pack' do
        expect(subject).to be_a(Pack)
      end
    end
  end

  describe '#find_by_capacity!' do
    subject { pack_collection.find_by_capacity!(capacity) }

    context 'when there is no pack with this capacity' do
      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::NotFound)
      end
    end

    context 'when there is a pack with this capacity' do
      it 'returns a product' do
        pack = pack_collection.add(capacity: capacity, price: price)
        expect(subject).to eq(pack)
      end
    end
  end
end
