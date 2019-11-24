# frozen_string_literal: true

describe Report::Exporter, :vcr do
  describe '#call!' do
    let(:report_file) { file_fixture('report.csv') }
    let(:report) { Report.load(report_file) }
    let(:data_source_uuid) { 'ds_07c64243-0d2d-11ea-b71e-8b59b4caa517' }
    let(:report_exporter) do
      described_class.new(report: report, data_source_uuid: data_source_uuid)
    end

    before do
      ChartMogul.account_token = '9db74c69772301a93ab08d04a09da15a'
      ChartMogul.secret_key = 'c4930cb0e7d6b2a3a1a5356290ec16ff'
    end

    subject { report_exporter.call! }

    describe 'with successful responses from exteranl service' do
      it "does not raise any error" do
        expect { subject }.to_not raise_error
      end
    end

    describe 'with unsuccessful responses from exteranl service' do
      it "raises an error" do
        expect { subject }.to raise_error(Report::Exporter::ImportingError)
      end
    end
  end
end
