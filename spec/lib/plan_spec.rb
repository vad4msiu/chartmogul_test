# frozen_string_literal: true

describe Plan do
  describe '#load_collection' do
    let(:table) do
      CSV.read(file_fixture('report.csv'), headers: true, return_headers: false)
    end

    subject { described_class.load_collection(table) }

    it 'returns list of plans' do
      expect(subject).to_not be_empty
      expect(subject).to all(be_kind_of(described_class))
    end
  end
end
