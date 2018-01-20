Container.boot(:logger) do
  use :configuration

  init do
    require 'logger'
  end

  start do
    register(:logger, Logger.new(*configuration.logger))
  end
end
