Container.boot(:inputs) do
  init do
    require 'dry-validation'

    Container.require_from_root 'web/inputs/base'
    Container.require_from_root 'web/inputs/**/*.rb'
  end
end
