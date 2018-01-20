Container.boot(:router) do
  init do
    require 'roda'
    require 'json'

    Container.require_from_root 'web/routes/base'
    Container.require_from_root 'web/routes/**/*.rb'
    Container.require_from_root 'web/router'
  end

  start do
    register(:router, Web::Router.freeze.app)
  end
end
