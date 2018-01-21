Container.require_from_root 'core/entities/base'

module Entities
  class Transaction < Base
    attribute :id,                            Types::Strict::Int.optional

    attribute :amount_currency,               Types::Strict::String
    attribute :amount_cents,                  Types::Strict::Int
    attribute :description,                   Types::Strict::String.optional

    attribute :created_at,                    Types::Strict::DateTime.constructor(&:to_datetime)
    attribute :updated_at,                    Types::Strict::DateTime.constructor(&:to_datetime)
  end
end
