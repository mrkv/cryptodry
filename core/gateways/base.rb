module Gateways
  class Base
    include IMPORT[:db, :configuration]

    # @param [Hash] params
    # @return [Integer]
    def count(params = {})
      db[table_name].where(params).count
    end

    # @param [Hash] params
    # @return [Entities::*]
    def find_by(params)
      return nil unless valid_uuids?(params)
      attributes = db[table_name][params]
      build_entity(attributes) unless attributes.nil?
    end

    # @param [Hash] params
    # @return [Array<Entities::*>]
    def filter_by(params, page_number: nil, page_size: nil)
      return [] unless valid_uuids?(params)
      dataset = db[table_name].where(params)
      attributes = paginate_dataset(dataset, page_number, page_size)
      attributes.map { |attrs| build_entity(attrs) }
    end

    # @param [Entities::*] entity
    # @return [Entities::*]
    # @raise [Errors::Base]
    def create(entity)
      raise Errors::Base if entity.nil?
      attributes = prepare_attributes(entity)
      id = db[table_name].insert(attributes)

      find_by(id: id)
    end

    # @param [Entities::*] entity
    # @return [Entities::*]
    # @raise [Errors::Base]
    def update(entity)
      id = entity.id
      raise Errors::Base if id.nil?

      attributes = prepare_attributes(entity)
      db[table_name].where(id: id).update(attributes)

      find_by(id: id)
    end

    protected

    # @return [Symbol]
    def table_name
      raise NotImplementedError
    end

    # @return [Array<Symbol>]
    def uuid_keys
      []
    end

    # @param [Hash] attributes
    # @return [Entities::*]
    def build_entity(attributes)
      raise NotImplementedError
    end

    # @param [Entities::*] entity
    # @return [Hash]
    def prepare_attributes(entity)
      raise NotImplementedError
    end

    # @param [Sequel::Postgres::Dataset] dataset
    # @param [String] page_number
    # @param [String] page_size
    # @return [Sequel::Postgres::Dataset]
    def paginate_dataset(dataset, page_number, page_size)
      return dataset if page_number.nil?

      page = page_number.to_i
      per_page = page_size&.to_i || configuration.per_page_size

      dataset.paginate(page, per_page)
    end

    # @param [Hash] params
    # @return [Boolean]
    def valid_uuids?(params)
      uuid_keys.map do |key|
        return false if params&.key?(key) && !UUIDValidator.valid?(params[key])
      end

      true
    end
  end
end
