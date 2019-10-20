# frozen_string_literal: true

describe Product do
  after { described_class.delete_all }

  let(:code) { 'some_code' }
  let(:name) { 'some_name' }

  describe '.add' do
    subject { described_class.add(code: code, name: name) }

    context 'when a code is nil' do
      let(:code) { nil }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'when a name is nil' do
      let(:name) { nil }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'when there is a product with the same code' do
      before { described_class.add(code: code, name: name) }

      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::InvalidValue)
      end
    end

    context 'when a name and code are present' do
      it 'returns a product' do
        expect(subject).to be_a(described_class)
      end
    end
  end

  describe '.find_by_code!' do
    subject { described_class.find_by_code!(code) }

    context 'when there is no product with this code' do
      it 'raises an exception' do
        expect {
          subject
        }.to raise_exception(described_class::NotFound)
      end
    end

    context 'when there is a product with this code' do
      it 'returns a product' do
        product = described_class.add(code: code, name: name)
        expect(subject).to eq(product)
      end
    end
  end

  describe '.delete_all' do
    subject { described_class.delete_all }

    it 'deletes all products' do
      product = described_class.add(code: code, name: name)
      subject
      expect {
        described_class.find_by_code!(code)
      }.to raise_exception(described_class::NotFound)
    end
  end
end
