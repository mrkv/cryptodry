module UseCases
  class Base
    include IMPORT[:logger]

    protected

    # @param [Hash] params
    # @raise [Errors::InvalidRequest]
    def validate!(params)
      result = validate.call(params)
      raise Errors::InvalidRequest if result.failure?
    end
  end
end
