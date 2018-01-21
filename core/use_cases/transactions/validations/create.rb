Container.require_from_root 'core/use_cases/base'

module UseCases
  module Transactions
    module Validations
      class Create < Base
        include IMPORT[
          card_gateway: 'gateways.card'
        ]

        ERROR_MESSAGES = {
          en: {
            errors: {
              existance: 'card not exists',
              issuance_and_fraudulence: 'card is not issued or fraudulent'
            }
          }
        }.freeze

        SCHEMA = Dry::Validation.Form do
          configure do
            option :card_gateway

            def self.messages
              super.merge(ERROR_MESSAGES)
            end
          end

          required(:card_id).filled

          validate(existance: :card_id) do |card_id|
            card = card_gateway.find_by(id: card_id)
            !card.nil?
          end

          validate(issuance_and_fraudulence: :card_id) do |card_id|
            card = card_gateway.find_by(id: card_id)
            card&.issued && !card&.fraudulent
          end
        end

        # @param [Hash] params
        # @return [Dry::Validation::Result]
        def call(params)
          SCHEMA.with(card_gateway: card_gateway).call(params)
        end
      end
    end
  end
end
