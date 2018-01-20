class Transaction
  attr_reader :db

  # @param [Sequel::Postgres::Database] db
  def initialize(db)
    @db = db
  end

  # Wraps passed block into Sequel transaction. Rollback on any error and reraise it.
  def begin
    db.transaction do
      yield
    end
  end
end
