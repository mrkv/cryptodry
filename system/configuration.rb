class Configuration
  def version
    '1.0.0'
  end

  def db
    {
      adapter:       'postgresql',
      encoding:      'unicode',
      database:      db_name,
      user:          ENV.fetch('DATABASE_USER'),
      password:      ENV.fetch('DATABASE_PASS'),
      host:          ENV.fetch('DATABASE_HOST'),
      port:          ENV.fetch('DATABASE_PORT').to_i,
      pool:          ENV.fetch('DATABASE_POOL').to_i,
      sql_log_level: :debug
    }
  end

  def db_name
    ENV.fetch('DATABASE_NAME')
  end

  def logger
    [
      STDOUT
    ]
  end
end
