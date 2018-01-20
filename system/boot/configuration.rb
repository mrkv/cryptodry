Container.boot(:configuration) do
  init do
    Container.require_from_root 'system/configuration'
  end

  start do
    register(:configuration, Configuration.new)
  end
end
