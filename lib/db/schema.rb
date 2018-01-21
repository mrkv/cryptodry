class Schema
  include IMPORT[:db]

  def load
    db.transaction do
      db.run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

      define_cards(db)
      define_transactions(db)
    end
  end

  protected

  def define_cards(db)
    db.create_table!(:cards) do
      primary_key :id

      column :uuid,                       :uuid, index: true, default: Sequel.function(:uuid_generate_v4)
      column :user_id,                    :integer
      column :issued,                     :boolean, default: false
      column :fraudulent,                 :boolean, default: false
      column :virtual,                    :boolean, default: false
      column :third_party_service_status, :text
      column :status,                     :text

      column :created_at, :timestamptz
      column :updated_at, :timestamptz
    end
  end

  def define_transactions(db)
    db.create_table!(:transactions) do
      primary_key :id

      column :external_reference, :integer, index: true
      column :amount_currency,    :text
      column :amount_cents,       :integer
      column :description,        :text

      column :created_at, :timestamptz
      column :updated_at, :timestamptz
    end
  end
end
