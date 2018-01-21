require_relative '../../test_helper'

describe UseCases::Transactions::Create do
  let!(:service) do
    service = double(:service)
    Container.stub(:service, service)
    service
  end

  let!(:validate) do
    validate = double(:validate)
    Container.stub('use_cases.transactions.validations.create', validate)
    validate
  end

  let!(:card_gateway) do
    card_gateway = double(:card_gateway)
    Container.stub('gateways.card', card_gateway)
    card_gateway
  end

  let!(:transaction_gateway) do
    transaction_gateway = double(:transaction_gateway)
    Container.stub('gateways.transaction', transaction_gateway)
    transaction_gateway
  end

  let(:use_case) { Container.resolve('use_cases.transactions.create') }

  let(:params) do
    {
      card_id: 1
    }
  end

  after(:all) do
    Container.unstub('use_cases.transactions.validations.create')
    Container.unstub('gateways.card')
    Container.unstub('gateways.transaction')
    Container.unstub(:service)
  end

  context 'card not exists' do
    it 'raises error' do
      expect(validate).to receive(:call).with(params)
                                        .and_return(double(:result, failure?: true, messages: {}))
      expect { use_case.call(params) }.to raise_error(Errors::InvalidRequest)
    end
  end

  context 'card exists and valid' do
    let(:card) { build(:card) }
    let(:transaction) { build(:transaction) }

    it 'creates transactions and returns transactions count' do
      expect(validate).to receive(:call).with(params)
                                        .and_return(double(:result, failure?: false))
      expect(transaction_gateway).to receive(:create).at_least(:once).and_return(transaction)

      result = use_case.call(params)
      expect(result).to be_kind_of(Integer)
    end
  end
end
