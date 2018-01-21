module UseCases
  class Base
    include IMPORT[:logger]

    protected

    # @param [Hash] params
    # @raise [Errors::InvalidRequest]
    def validate!(params)
      result = validate.call(params)
      # raise Errors::InvalidRequest, ValidationMessageRenderer.to_string(result) if result.failure?
      raise Errors::InvalidRequest if result.failure?
    end
  end
end
