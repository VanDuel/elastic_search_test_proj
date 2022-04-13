module Api
  module V1
    class BaseResource
      include Alba::Resource

      class_attribute :default_within_options, :specific_resource

      class << self
        # rubocop:disable Metrics/ParameterLists
        def many(name, condition = nil, resource: nil, key: nil, **options, &block)
          options[:if] = proc { check_within(name) } unless options[:if]

          super
        end
        alias has_many many

        def one(name, condition = nil, resource: nil, key: nil, **options, &block)
          options[:if] = proc { check_within(name) } unless options[:if]

          super
        end
        alias has_one one
        # rubocop:enable Metrics/ParameterLists

        # Predefine default associations to be serialized for resource
        #
        # @param within [Hash]
        def default_within(within)
          self.default_within_options = within
        end
      end

      def initialize(object, params: {}, within: WITHIN_DEFAULT)
        # -------------------------------------------------------------------------
        # TODO Получается, Single и Enumerable Resource не нужны... - на всякий пока оставляю
        # if params[:single_iteration].nil? #&& params(:single_iteration) == true
        super
        #
        #   if collection?
        #     EnumerableResource.new(object, self.class)
        #     # collection_resource(self.class)
        #   else
        #     SingleResource.new(object, self.class)
        #   end
        # end
        # -------------------------------------------------------------------------

        return if @within != WITHIN_DEFAULT
        return if default_within_options.nil?

        @within = default_within_options

      end

      def collection?
        super && !@object.is_a?(Hash)
      end

      # def collection_resource(resource)
      #   self.specific_resource = resource
      # end
      #
      # def serializable_hash
      #   converter.call(@object)
      # end
      # alias to_hash serializable_hash

    end

    # module AttrInsert
    #   include Alba::Resource
    #
    #   attribute(:items) do |object|
    #     if object.is_a?(Array)
    #       specific_resource.new(object, params: @params, within: @within).to_hash
    #     end
    #   end
    # end
  end
end
