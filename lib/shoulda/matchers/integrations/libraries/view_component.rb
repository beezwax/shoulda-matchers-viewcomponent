# frozen_string_literal: true

module Shoulda
  module Matchers
    module Integrations
      module Libraries
        class ViewComponent
          Integrations.register_library(self, :view_component)

          include Integrations::Inclusion
          include Integrations::Rails

          def integrate_with(test_framework)
            test_framework.include(matchers_module, type: :component)

            #include_into(::ViewComponent::TestCase, matchers_module) do
            #  def subject # rubocop:disable Lint/NestedMethodDefinition
            #    @component
            #  end
            #end
          end

          private

          def matchers_module
            Shoulda::Matchers::ViewComponent
          end
        end
      end
    end
  end
end
