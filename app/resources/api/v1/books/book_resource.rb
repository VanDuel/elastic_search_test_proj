module Api
  module V1
    module Books
      class BookResource < Api::V1::BaseResource
        # default_within schemas: :schemas_conditions

        attributes :id,
                   :name,
                   :price,
                   :author

        # has_many :schemas, resource: Api::V2::Schemas::SchemaResource
      end
    end
  end
end