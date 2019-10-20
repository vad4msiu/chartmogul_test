# frozen_string_literal: true

describe Pack do
  let(:capacity) { 1 }
  let(:price) { 10 }

  describe '.new' do
    subject { described_class.new(capacity: capacity, price: price) }

    context 'when capacity is negative' do
      let(:capacity) { -1 }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'when price is negative' do
      let(:price) { -1 }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'when a capacity and price are positive' do
      it 'returns a pack' do
        expect(subject).to be_a(described_class)
      end
    end

    it 'convert price to money class' do
      expect(subject.price).to be_a(Money)
    end
  end
end
