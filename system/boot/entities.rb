Container.boot(:entities) do
  init do
    require 'dry-types'
    require 'dry-struct'

    module Types
      include Dry::Types.module
    end

    Container.require_from_root 'core/entities/**/*.rb'
  end
end
