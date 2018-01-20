Container.boot(:presenters) do
  init do
    require 'roar/decorator'
    require 'roar/json'
    require 'roar/json/hash'

    Container.require_from_root 'web/presenters/**/*.rb'
  end
end
