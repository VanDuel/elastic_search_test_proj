module Api
  module V1
    class ErrorsResource < Api::V1::BaseResource
      attribute(:non_field_errors) { errors_hash[:base] }

      class_attribute :mapped_attributes
      def self.map_error_attribute(new_name, old_name)
        self.mapped_attributes ||= {}
        self.mapped_attributes[old_name.to_s] = new_name
      end

      def serializable_hash
        super.merge(mapped_errors.except(:base))
      end
      alias to_hash serializable_hash

      private

      def mapped_errors
        return errors_hash if self.mapped_attributes.blank?

        errors_hash.transform_keys do |key|
          self.mapped_attributes.key?(key.to_s) ? self.mapped_attributes[key.to_s] : key
        end
      end

      def errors_hash
        @errors_hash ||= @object.is_a?(Hash) ? @object : @object.errors.to_hash
      end

      def converter
        super >> proc { |hash| hash.compact }
      end

      def collection?
        !@object.is_a?(Hash) && super
      end
    end
  end
end
