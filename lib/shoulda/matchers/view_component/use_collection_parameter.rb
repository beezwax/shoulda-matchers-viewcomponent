# frozen_string_literal: true

module Shoulda
  module Matchers
    module ViewComponent
      # The `use_collection_parameter` matcher tests usage of the
      # `with_collection_parameter` macro.
      #
      #     class ProductComponent < ViewComponent::Base
      #       with_collection_parameter :product
      #
      #       def initialize(product:)
      #       end
      #     end
      #
      #     # RSpec
      #     RSpec.describe ProductComponent, type: :component do
      #       it { expect(described_class).to use_collection_parameter(:product) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class ProductComponentTest < ActiveSupport::TestCase
      #       should use_collection_parameter(:product)
      #     end
      #
      # @return [HaveReadonlyAttributeMatcher]
      #
      def use_collection_parameter(value)
        UseCollectionParameter.new(value)
      end

      # @private
      class UseCollectionParameter
        def initialize(attribute)
          @attribute = attribute.to_s
        end

        def matches?(subject)
          @subject = subject

          collection_parameter_matches? &&
            has_matching_initialize_parameter? &&
            requires_counter? && requires_iteration?
        end

        def description
          description = "use collection parameter " \
            ":#{@attribute} with matching #initialize(#{@attribute}:"

          if @with_counter
            description += ", #{@attribute}_counter:"
          end

          if @with_iteration
            description += ", #{@attribute}_iteration:"
          end

          description += '[, ...]) keyword argument'

          description += 's' if @with_counter || @with_iteration

          description
        end

        def failure_message
          "expected #{@subject} to #{description}"
        end

        def failure_message_when_negated
          "expected #{@subject} not to #{description}"
        end

        def with_counter
          @with_counter = true
          self
        end

        def with_iteration
          @with_iteration = true
          self
        end

        private

        def collection_parameter_matches?
          @subject.collection_parameter.to_s == @attribute
        end

        def has_matching_initialize_parameter?
          has_keyword_parameter?(@attribute)
        end

        def requires_counter?
          return true unless @with_counter
          has_keyword_parameter?("#{@attribute}_counter")
        end

        def requires_iteration?
          return true unless @with_iteration
          has_keyword_parameter?("#{@attribute}_iteration")
        end

        def has_keyword_parameter?(parameter)
          @subject.instance_method(:initialize).parameters.any? do |(type, name)|
            type == :keyreq && name.to_s == parameter
          end
        end
      end
    end
  end
end
