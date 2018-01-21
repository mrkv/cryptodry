Container.require_from_root 'core/use_cases/base'
Container.require_from_root 'lib/utils/transaction'

module UseCases
  module Transactions
    class Create < Base
      include IMPORT[
        :db,
        gateway: 'gateways.transaction',
        service: 'services.third_party_service',
        validate: 'use_cases.transactions.validations.create'
      ]

      # @param [Hash] params
      # @return [Integer]
      def call(params)
        validate!(params)

        transactions = JSON.parse(service.call(params[:card_id]), {:symbolize_names => true})
        Transaction.new(db).begin do
          transactions[:transactionDetails].each do |transaction|
            gateway.create(
              Entities::Transaction.new(
                default_params.merge(transaction_params(transaction))
              )
            )
          end
        end

        transactions.length
      end

      private

      def default_params
        {
          created_at: DateTime.now,
          updated_at: DateTime.now
        }
      end

      def transaction_params(transaction)
        {
          external_reference: transaction[:transactionId],
          amount_currency: transaction[:transactionCurrency],
          amount_cents: transaction[:transactionAmount],
          description: transaction[:description] || transaction[:comment]
        }
      end
    end
  end
end
