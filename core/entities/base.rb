module Entities
  class Base < Dry::Struct::Value
    constructor_type :schema

    # Build new entity with current attributes deeply merged with new ones.
    # entity.new replaces attributes instead of merge
    # @param [Hash] attributes
    # @return [Entities::*]
    def rebuild_with(attributes)
      self.class.new(to_h.deep_merge(attributes))
    end
  end
end
