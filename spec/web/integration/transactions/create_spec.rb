require_relative '../../../test_helper'

describe Web::Controllers::Transactions::Create do
  let(:gateway) { Container.resolve('gateways.card') }
  let(:url) { 'api/v1/transactions' }

  let!(:use_case) do
    use_case = double(:use_case)
    Container.stub('use_cases.transactions.create', use_case)
    use_case
  end

  before(:each) do
    header 'Content-Type', 'application/json;charset=UTF-8'
  end

  context 'invalid params' do
    it 'returns response with error' do
      post url, nil

      expect(last_response.status).to eq 400
      expect_valid_headers
      expect(json_body[:code]).to eq 400
    end
  end

  context 'valid params' do
    let!(:card) { gateway.create(build(:card)) }
    let(:payload) do
      {
        card_id: card.id
      }
    end

    it 'returns response with success' do
      expect(use_case).to receive(:call).with(payload)
      post url, JSON.generate(payload)

      expect(last_response.status).to eq 200
      expect_valid_headers
      expect(json_body[:result]).to include('Successfully synced')
    end
  end
end
