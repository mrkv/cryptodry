module Errors
  class Base < StandardError
    def initialize(message = nil)
      super
      Container.resolve(:logger).error("#{self.class.name}: #{message}")
    end
  end
end
