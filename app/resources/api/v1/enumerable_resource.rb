module Api
  module V1
    class EnumerableResource < Api::V1::BaseResource
      class_attribute :specific_resource

      def initialize(object, specific_resource, **args)
        self.specific_resource = specific_resource

        if @params.nil?
          @params = {single_iteration: false}
        else
          @params[:single_iteration] = false
        end
      end

      def serializable_hash
        converter.call(@object)
      end
      alias to_hash serializable_hash

      attribute(:items) do |object|
        specific_resource.new(object, params: @params, within: @within).to_hash
      end
    end
  end
end
