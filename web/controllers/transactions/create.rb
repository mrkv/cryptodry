module Web
  module Controllers
    module Transactions
      class Create < Base
        include IMPORT[use_case: 'use_cases.transactions.create']

        # Creates new captcha
        # @param [Hash] params
        # @return [Integer]
        def call(params)
          inputs = Web::Inputs::Transaction::Create.new.call(params)
          raise Errors::InvalidRequest if inputs.failure?

          use_case.call(inputs.to_h)
        end
      end
    end
  end
end
