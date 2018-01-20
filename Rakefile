task :environment do
  require_relative 'system/boot'
end

namespace :db do
  desc 'Recreate database from schema'
  task setup: :environment do
    require_relative 'lib/db/schema'

    Schema.new.load
  end

  desc 'Run migrations'
  task :migrate, [:version] => :environment do |_t, args|
    db = Container.resolve(:db)

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, 'lib/db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'lib/db/migrations')
    end

    puts '<= db:migrate executed'
  end

  desc 'Run migrations rollback'
  task :rollback, [:version] => :environment do |_t, args|
    db = Container.resolve(:db)

    if args[:version]
      puts "Rollback to version #{args[:version]}"
      Sequel::Migrator.run(db, 'lib/db/migrations', target: args[:version].to_i)
    else
      version = db.tables.include?(:schema_info) ? db[:schema_info].first[:version].to_i - 1 : 0
      puts 'Rollback to previous'
      Sequel::Migrator.run(db, 'lib/db/migrations', target: version)
      puts "Schema Version: #{version}"
    end

    puts '<= db:rollback executed'
  end

  desc 'Seed database'
  task seed: :environment do
    require_relative 'lib/db/seeds'

    Seeds.new.run

    puts '<= db:seed executed'
  end
end
