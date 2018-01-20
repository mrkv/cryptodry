Container.boot(:errors) do
  init do
    Container.require_from_root 'lib/errors/**/*.rb'
  end
end
