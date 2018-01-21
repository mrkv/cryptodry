Container.require_from_root 'web/inputs/base'

module Web
  module Inputs
    module Transaction
      class Create < Base
        def schema
          Dry::Validation.Form do
            required(:card_id).filled(:int?)
          end
        end
      end
    end
  end
end
