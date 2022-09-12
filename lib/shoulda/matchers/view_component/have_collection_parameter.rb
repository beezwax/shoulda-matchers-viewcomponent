# frozen_string_literal: true

module Shoulda
  module Matchers
    module ViewComponent
      # The `have_readonly_attribute` matcher tests usage of the
      # `attr_readonly` macro.
      #
      #     class User < ActiveRecord::Base
      #       attr_readonly :password
      #     end
      #
      #     # RSpec
      #     RSpec.describe User, type: :model do
      #       it { should have_readonly_attribute(:password) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class UserTest < ActiveSupport::TestCase
      #       should have_readonly_attribute(:password)
      #     end
      #
      # @return [HaveReadonlyAttributeMatcher]
      #
      def have_collection_parameter(value)
        HaveCollectionParameter.new(value)
      end

      # @private
      class HaveCollectionParameter
        def initialize(attribute)
          @attribute = attribute.to_s
        end

        def matches?(subject)
          @subject = subject

          collection_parameter_matches? &&
            has_matching_initialize_parameter? &&
            requires_counter? && requires_iteration?
        end

        def failure_message
          "Expected #{@subject} to have collection parameter " \
            ":#{@attribute} with matching #initialize(#{@attribute}:[, ...]) " \
            'keyword argument'
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
          puts "collection_parameter_matches?"
          @subject.collection_parameter.to_s == @attribute
        end

        def has_matching_initialize_parameter?
          puts "has_matching_initialize_parameter?"
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
