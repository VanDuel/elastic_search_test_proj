module Api
  module V1
    class EnumerableResource < Api::V1::BaseResource
      class_attribute :base_resource

      def self.collection_resource(resource)
        self.base_resource = resource
      end

      attribute(:items) do |object|
        base_resource.new(object, params: @params, within: @within).to_hash
      end

      def initialize(object, **args)
        if base_resource.blank?
          resource_name = self.class.name.delete_suffix('Resource')
          resource_name = "#{resource_name.singularize}Resource"
          self.base_resource = resource_name.safe_constantize
        end

        super
      end

      def serializable_hash
        converter.call(@object)
      end
      alias to_hash serializable_hash
    end
  end
end
