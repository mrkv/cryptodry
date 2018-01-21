require_relative '../../../test_helper'

describe UseCases::Transactions::Validations::Create do
  let!(:card_gateway) do
    gateway = double(:gateway)
    Container.stub('gateways.card', gateway)
    gateway
  end

  after(:all) do
    Container.unstub('gateways.card')
  end

  let(:use_case) { Container.resolve('use_cases.transactions.validations.create') }
  let(:params) do
    {
      card_id: 1
    }
  end

  context 'card not exists' do
    it 'returns failure' do
      expect(card_gateway).to receive(:find_by).twice.and_return(nil)
      expect(use_case.call(params).success?).to eq false
    end
  end
  context 'card exists' do
    context 'card not issued' do
      let(:card) { build(:card, issued: false) }

      it 'returns failure' do
        expect(card_gateway).to receive(:find_by).twice.and_return(card)
        expect(use_case.call(params).success?).to eq false
      end
    end
    context 'card fraudulent' do
      let(:card) { build(:card, fraudulent: true) }

      it 'returns failure' do
        expect(card_gateway).to receive(:find_by).twice.and_return(card)
        expect(use_case.call(params).success?).to eq false
      end
    end
    context 'card issued and not fraudulent' do
      let(:card) { build(:card, issued: true, fraudulent: false) }

      it 'returns success' do
        expect(card_gateway).to receive(:find_by).twice.and_return(card)
        expect(use_case.call(params).success?).to eq true
      end
    end
  end
end
