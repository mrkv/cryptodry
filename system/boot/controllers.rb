Container.boot(:controllers) do
  init do
    Container.require_from_root 'lib/errors/invalid_request'

    Container.require_from_root 'web/controllers/base'
    Container.require_from_root 'web/controllers/**/*.rb'
  end
end
