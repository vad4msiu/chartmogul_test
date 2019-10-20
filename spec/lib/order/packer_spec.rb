# frozen_string_literal: true

describe Order::Packer do
  describe '.pack' do
    let(:target) { 1 }
    let(:capacities) { [1] }

    subject { described_class.pack(target: target, capacities: capacities) }

    context 'with negative target' do
      let(:target) { -1 }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'with correct target' do
      let(:target) { 10 }

      context 'with correct capacities' do
        let(:capacities) { [5] }

        it 'returns correct packs' do
          expect(subject).to eq([5, 5])
        end

        context 'with few possible solutions' do
          let(:capacities) { [2, 5] }

          it 'returns correct packs' do
            expect(subject).to eq([5, 5])
          end
        end
      end

      context 'with incorrect capacities' do
        let(:capacities) { [3] }

        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
    end
  end
end
