Container.require_from_root 'core/entities/base'

module Entities
  class Card < Base
    attribute :id,                            Types::Strict::Int.optional

    attribute :uuid,                          Types::Strict::String
    attribute :user_id,                       Types::Strict::Int
    attribute :issued,                        Types::Strict::Bool.optional
    attribute :fraudulent,                    Types::Strict::Bool.optional
    attribute :virtual,                       Types::Strict::Bool.optional
    attribute :third_party_service_status,    Types::Strict::String.optional
    attribute :status,                        Types::Strict::String.optional

    attribute :created_at,                    Types::Strict::DateTime.constructor(&:to_datetime)
    attribute :updated_at,                    Types::Strict::DateTime.constructor(&:to_datetime)
  end
end
