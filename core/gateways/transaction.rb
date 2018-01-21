Container.require_from_root 'core/gateways/base'

module Gateways
  class Transaction < Base
    protected

    def table_name
      :transactions
    end

    def build_entity(attributes)
      Entities::Transaction.new(attributes)
    end

    def prepare_attributes(transaction)
      hash = transaction.to_h
      hash.delete(:id)
      hash
    end
  end
end
