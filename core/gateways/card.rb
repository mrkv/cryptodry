Container.require_from_root 'core/gateways/base'

module Gateways
  class Card < Base
    protected

    def table_name
      :cards
    end

    def build_entity(attributes)
      Entities::Card.new(attributes)
    end

    def prepare_attributes(card)
      hash = card.to_h
      hash.delete(:id)
      hash
    end
  end
end
