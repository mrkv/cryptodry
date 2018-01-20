module Web
  module Inputs
    class Base
      # @param [Hash] params
      # @return [Dry::Validation::Result]
      def call(params)
        schema.call(params)
      end

      protected

      def schema
        raise NotImplementedError
      end
    end
  end
end
