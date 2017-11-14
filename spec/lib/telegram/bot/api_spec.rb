RSpec.describe Telegram::Bot::Api do
  let(:default_token) { '180956132:AAHU0_CeyQWOd6baBc9TibTPybxY9p1P8xo' }
  let(:token) { ENV.fetch('BOT_TOKEN', default_token) }
  let(:api) { described_class.new(token) }

  describe '#call' do
    subject(:api_call) { api.call(endpoint) }

    let(:endpoint) { 'getMe' }

    it 'returns hash' do
      is_expected.to be_a(Hash)
    end

    it 'has status' do
      is_expected.to have_key('ok')
    end

    it 'has result' do
      is_expected.to have_key('result')
    end

    context 'when token is invalid' do
      let(:token) { '123456:wrongtoken' }

      it 'raises an error' do
        expect { api_call }
          .to raise_error(Telegram::Bot::Exceptions::ResponseError)
      end
    end
  end

  describe '#method_missing' do
    subject { api }

    let(:endpoint) { 'getMe' }

    it 'responds to endpoints' do
      is_expected.to respond_to(endpoint)
    end

    context 'when method name is in snake case' do
      let(:endpoint) { 'get_me' }

      it 'responds to snake-cased endpoints' do
        is_expected.to respond_to(endpoint)
      end
    end
  end

  describe '#send_invoice' do
    subject { api.send_invoice(params) }

    let(:token) { '206016752:AAH0SXG4DNqfahfz4Q7gHnaYbg-xa2nkB8c' }
    let(:params) do
      {
        chat_id: 151031480,
        title: 'Hope Invoice',
        description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod',
        payload: 'LWJKHDFQ<WFK<QJFHJk',
        provider_token: '284685063:TEST:MzliOGFmZTRjM2Ez',
        start_parameter: 'WD6354FKJQ523446LWEFHN354LQEHFOHFLJKFNBLhn',
        currency: 'RUB',
        prices: [{amount: 105_00, label: "PriceLabel_1" }, {amount: 107_00, label: "PriceLabel_2"}]
      }
    end

    specify { subject }
  end
end
