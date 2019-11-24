# frozen_string_literal: true

describe Report do
  describe '#load' do
    let(:report_file) { file_fixture('report.csv') }

    subject { described_class.load(report_file) }

    it 'loads report' do
      expect(subject).to be_kind_of(described_class)
    end
  end

  describe '#customers' do
    let(:report_file) { file_fixture('report.csv') }

    subject { described_class.load(report_file).customers }

    context 'with duplicate customer id' do
      let(:report_file) { file_fixture('report_with_duplicates.csv') }

      it 'returns list of unique customers' do
        expect(subject.map(&:id)).to eq(%w(petr hassan))
      end
    end
  end

  describe '#plans' do
    let(:report_file) { file_fixture('report.csv') }

    subject { described_class.load(report_file).plans }

    context 'with duplicate plan id' do
      let(:report_file) { file_fixture('report_with_duplicates.csv') }

      it 'returns list of unique plans' do
        expect(subject.map(&:id)).to eq(%w(monthly_plan))
      end
    end
  end
end
