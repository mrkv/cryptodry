require_relative '../../../test_helper'

describe Web::Inputs::Transaction::Create do
  let(:input) { described_class.new }

  let(:params) do
    attributes_for(:transaction).slice(:card_id)
  end

  context 'transaction with valid card id' do
    it 'returns success' do
      result = input.call(params.merge(INVALID_ATTRIBUTE: :INVALID_ATTRIBUTE))
      expect(result.success?).to eq true
      expect(result.to_h.key?(:INVALID_ATTRIBUTE)).to eq false
      expect(result.to_h).to eq params
    end
  end

  context 'captcha with invalid phone number' do
    it 'fails' do
      expect(input.call(params.merge(card_id: nil)).success?).to eq false
    end
  end
end
