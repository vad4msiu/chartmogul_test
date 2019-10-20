# frozen_string_literal: true

describe Pack do
  let(:capacity) { 1 }
  let(:price) { 10 }

  describe '.to_s' do
    before do
      Utils.load_data(
        file_fixture("data.json").path
      )
    end

    let(:order) do
      Utils.process_order(
        file_fixture("order.json").path
      )
    end

    it 'returns the order information' do
      expect(order.to_s).to eq <<-STR
10 VS5 $17.98
  2 x 5 $17.98
14 MB11 $54.80
  1 x 8 $24.95
  3 x 2 $29.85
13 CF $25.85
  2 x 5 $19.90
  1 x 3 $5.95
      STR
    end
  end
end
