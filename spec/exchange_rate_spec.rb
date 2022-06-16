RSpec.describe ExchangeRate do
  describe ExchangeRate::Converter, :vcr do

    describe '#call' do
      subject { described_class.new(cueerncy_from, cueerncy_to, amount).call }

      let(:cueerncy_from) { 'USD' }
      let(:cueerncy_to) { 'EUR' }
      let(:amount) { 1000 }
      let(:query) { "https://api.exchangerate.host/converts?from=#{cueerncy_from}&to=#{cueerncy_to}&amount=#{amount}" }

      context 'when api returns success result' do
        let(:result) do
          { 'result'=>957.986224, 'success'=>true, 'info'=>{'rate'=>0.957986} }
        end

        it 'equals result' do
          expect(subject).to eq result
        end
      end

      context 'when params are invalid' do
        let(:cueerncy_to) { 'Error' }
        let(:result) do
          { 'msg' => 'Params are invalid', 'success' => false }
        end

        it 'equals nil' do
          expect(subject).to eq result
        end
      end
    end
  end
end
