FactoryBot.define do
  factory :card, class: Entities::Card do
    initialize_with { new(attributes) }

    id { rand(999_999_999) }
    uuid  { SecureRandom.uuid }
    user_id { rand(999_999_999) }
    issued true
    fraudulent false
    virtual true
    third_party_service_status 'suspended'
    status 'suspended'

    created_at { DateTime.now }
    updated_at { DateTime.now }
  end

  factory :transaction, class: Entities::Transaction do
    initialize_with { new(attributes) }

    id { rand(999_999_999) }
    card_id { rand(999_999_999) }
    amount_currency { 'USD' }
    amount_cents { rand(999_999_999) }
    description 'description'

    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
