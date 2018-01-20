Container.require_from_root 'lib/errors/base'

module Errors
  class Forwarded < Base
    attr_reader :code, :name

    def initialize(message = nil, code = nil, name = nil)
      super(message)
      @code = code
      @name = name
    end
  end
end
