module Api
  module V1
    class BaseResource
      include Alba::Resource

      class_attribute :default_within_options

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
        super

        return if @within != WITHIN_DEFAULT
        return if default_within_options.nil?

        @within = default_within_options

      end

    end
  end
end
