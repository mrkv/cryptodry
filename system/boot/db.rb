Container.boot(:db) do
  use :logger
  use :configuration

  init do
    require 'sequel'
  end

  start do
    config = configuration.db.merge(loggers: [logger])
    Sequel.extension :migration
    db = Sequel.connect(config).extension(:pg_array, :pg_json, :pagination)
    register(:db, db)
  end
end
