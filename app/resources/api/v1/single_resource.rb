module Api
  module V1
    class SingleResource < Api::V1::BaseResource
      class_attribute :specific_resource

      def self.collection_resource(resource)
        self.specific_resource = resource
      end

      def initialize(object, specific_resource, **args)
        if @params.nil?
          @params = {single_iteration: false}
        else
          @params[:single_iteration] = false
        end
        specific_resource.new(object, params: @params, within: @within)

      end
    end
  end
end
